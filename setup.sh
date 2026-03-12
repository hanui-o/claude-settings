#!/bin/bash
set -e

REPO_URL="https://raw.githubusercontent.com/hanui-o/claude-settings/main"
TARGET_DIR=".claude"

echo "🔧 Claude Code 설정을 현재 프로젝트에 설치합니다..."

# .claude/commands 디렉토리 생성
mkdir -p "$TARGET_DIR/commands"

# 커맨드 목록
COMMANDS=(dev review commit update prd build perf a11y)

for cmd in "${COMMANDS[@]}"; do
  if [ -f "$TARGET_DIR/commands/$cmd.md" ]; then
    echo "  ⏭ commands/$cmd.md (이미 존재, 스킵)"
  else
    curl -sL "$REPO_URL/commands/$cmd.md" -o "$TARGET_DIR/commands/$cmd.md"
    echo "  ✅ commands/$cmd.md"
  fi
done

# CLAUDE.md 템플릿 (없을 때만)
if [ ! -f "CLAUDE.md" ]; then
  curl -sL "$REPO_URL/CLAUDE.md.template" -o "CLAUDE.md"
  echo "  ✅ CLAUDE.md (템플릿 생성 — 프로젝트에 맞게 수정하세요)"
else
  echo "  ⏭ CLAUDE.md (이미 존재, 스킵)"
fi

echo ""
echo "✅ 설치 완료! 사용 가능한 커맨드:"
for cmd in "${COMMANDS[@]}"; do
  echo "  /$cmd"
done
