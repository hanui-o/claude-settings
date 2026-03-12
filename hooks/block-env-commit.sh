#!/bin/bash
# Hook: PreToolUse (Bash)
# .env 파일이 포함된 git add/commit을 차단한다
#
# .claude/settings.json 에 다음과 같이 등록:
# {
#   "hooks": {
#     "PreToolUse": [
#       {
#         "matcher": "Bash",
#         "hooks": [
#           {
#             "type": "command",
#             "command": "./.claude/hooks/block-env-commit.sh"
#           }
#         ]
#       }
#     ]
#   }
# }

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ -z "$COMMAND" ]; then
  exit 0
fi

# git add에 .env 파일이 포함되어 있는지 확인
if echo "$COMMAND" | grep -qE 'git\s+add\s+.*\.env(\s|$|\.local|\.production|\.development)'; then
  echo "❌ .env 파일을 스테이징할 수 없습니다. 민감 정보가 커밋될 수 있습니다."
  echo "   .gitignore에 .env를 추가하세요."
  exit 2
fi

# git add -A 또는 git add . 인 경우 .env 파일 존재 여부 확인
if echo "$COMMAND" | grep -qE 'git\s+add\s+(-A|\.)'; then
  if ls .env .env.local .env.production .env.development 2>/dev/null | head -1 > /dev/null 2>&1; then
    if ! grep -qE '^\s*\.env' .gitignore 2>/dev/null; then
      echo "⚠️  .env 파일이 존재하지만 .gitignore에 등록되지 않았습니다."
      echo "   git add -A 대신 파일을 명시적으로 지정하거나, .gitignore에 .env를 추가하세요."
      exit 2
    fi
  fi
fi

exit 0
