#!/bin/bash
# Hook: PostToolUse (Edit|Write)
# 마이그레이션 파일 작성 시 위험한 패턴을 감지한다
#
# .claude/settings.json 에 다음과 같이 등록:
# {
#   "hooks": {
#     "PostToolUse": [
#       {
#         "matcher": "Edit|Write",
#         "hooks": [
#           {
#             "type": "command",
#             "command": "./.claude/hooks/validate-migration.sh"
#           }
#         ]
#       }
#     ]
#   }
# }

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# 마이그레이션 파일인지 확인 (migrations/, prisma/migrations/ 등)
if ! echo "$FILE_PATH" | grep -qiE '(migration|migrate)'; then
  exit 0
fi

# 파일이 존재하는지 확인
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

WARNINGS=""

# DROP TABLE 감지
if grep -qiE 'DROP\s+TABLE' "$FILE_PATH"; then
  WARNINGS="${WARNINGS}\n⚠️  DROP TABLE 감지: 테이블 삭제는 되돌릴 수 없습니다."
fi

# DROP COLUMN 감지
if grep -qiE 'DROP\s+COLUMN|removeColumn|dropColumn' "$FILE_PATH"; then
  WARNINGS="${WARNINGS}\n⚠️  DROP COLUMN 감지: 컬럼 삭제로 데이터가 유실될 수 있습니다."
fi

# TRUNCATE 감지
if grep -qiE 'TRUNCATE' "$FILE_PATH"; then
  WARNINGS="${WARNINGS}\n⚠️  TRUNCATE 감지: 모든 데이터가 삭제됩니다."
fi

# CASCADE 감지
if grep -qiE 'CASCADE' "$FILE_PATH"; then
  WARNINGS="${WARNINGS}\n⚠️  CASCADE 감지: 연관 데이터가 함께 삭제/변경될 수 있습니다."
fi

# NOT NULL without DEFAULT 감지
if grep -qiE 'NOT\s+NULL' "$FILE_PATH"; then
  if ! grep -qiE 'DEFAULT' "$FILE_PATH"; then
    WARNINGS="${WARNINGS}\n⚠️  NOT NULL 컬럼에 DEFAULT 값이 없으면 기존 데이터가 있는 테이블에서 에러가 발생할 수 있습니다."
  fi
fi

if [ -n "$WARNINGS" ]; then
  echo "🔍 마이그레이션 파일 검증 결과:"
  echo -e "$WARNINGS"
  echo ""
  echo "위 항목을 확인한 후 진행하세요."
fi

# 경고만 표시하고 차단하지는 않음
exit 0
