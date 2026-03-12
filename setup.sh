#!/bin/bash
set -e

REPO_URL="https://raw.githubusercontent.com/hanui-o/claude-settings/main"
TARGET_DIR=".claude"

echo "🔧 Claude Code 설정을 현재 프로젝트에 설치합니다..."
echo ""

# ──────────────────────────────────────
# 1. 슬래시 커맨드
# ──────────────────────────────────────
echo "📂 커맨드 설치..."
mkdir -p "$TARGET_DIR/commands"

COMMANDS=(dev review commit update prd build perf a11y component ui-review refactor test deploy optimize)

for cmd in "${COMMANDS[@]}"; do
  if [ -f "$TARGET_DIR/commands/$cmd.md" ]; then
    echo "  ⏭ commands/$cmd.md (이미 존재, 스킵)"
  else
    curl -sL "$REPO_URL/commands/$cmd.md" -o "$TARGET_DIR/commands/$cmd.md"
    echo "  ✅ commands/$cmd.md"
  fi
done

# ──────────────────────────────────────
# 2. 에이전트
# ──────────────────────────────────────
echo ""
echo "🤖 에이전트 설치..."
mkdir -p "$TARGET_DIR/agents"

AGENTS=(code-reviewer test-runner)

for agent in "${AGENTS[@]}"; do
  if [ -f "$TARGET_DIR/agents/$agent.md" ]; then
    echo "  ⏭ agents/$agent.md (이미 존재, 스킵)"
  else
    curl -sL "$REPO_URL/agents/$agent.md" -o "$TARGET_DIR/agents/$agent.md"
    echo "  ✅ agents/$agent.md"
  fi
done

# ──────────────────────────────────────
# 3. 훅 스크립트
# ──────────────────────────────────────
echo ""
echo "🪝 훅 스크립트 설치..."
mkdir -p "$TARGET_DIR/hooks"

HOOKS=(pre-commit-lint post-edit-format block-dangerous-commands)

for hook in "${HOOKS[@]}"; do
  if [ -f "$TARGET_DIR/hooks/$hook.sh" ]; then
    echo "  ⏭ hooks/$hook.sh (이미 존재, 스킵)"
  else
    curl -sL "$REPO_URL/hooks/$hook.sh" -o "$TARGET_DIR/hooks/$hook.sh"
    chmod +x "$TARGET_DIR/hooks/$hook.sh"
    echo "  ✅ hooks/$hook.sh"
  fi
done

# ──────────────────────────────────────
# 4. CLAUDE.md 템플릿
# ──────────────────────────────────────
echo ""
if [ ! -f "CLAUDE.md" ]; then
  curl -sL "$REPO_URL/CLAUDE.md.template" -o "CLAUDE.md"
  echo "📝 CLAUDE.md 템플릿 생성 — 프로젝트에 맞게 수정하세요"
else
  echo "⏭ CLAUDE.md (이미 존재, 스킵)"
fi

# ──────────────────────────────────────
# 완료
# ──────────────────────────────────────
echo ""
echo "✅ 설치 완료!"
echo ""
echo "사용 가능한 커맨드:"
for cmd in "${COMMANDS[@]}"; do
  echo "  /$cmd"
done
echo ""
echo "설치된 에이전트:"
for agent in "${AGENTS[@]}"; do
  echo "  🤖 $agent"
done
echo ""
echo "설치된 훅 (활성화하려면 .claude/settings.json에 등록하세요):"
for hook in "${HOOKS[@]}"; do
  echo "  🪝 $hook"
done
