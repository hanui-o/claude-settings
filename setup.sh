#!/bin/bash
set -e

REPO_URL="https://raw.githubusercontent.com/hanui-o/claude-settings/main"
TARGET_DIR=".claude"

echo "🔧 Claude Code 설정을 현재 프로젝트에 설치합니다..."
echo ""

# ──────────────────────────────────────
# claude-settings 레포 안에서 실행 방지
# ──────────────────────────────────────
if [ -f "setup.sh" ] && [ -d "commands" ] && [ -d "hooks" ]; then
  echo "⚠️  claude-settings 레포 안에서 실행한 것 같습니다."
  echo "   프로젝트 루트에서 아래 명령어로 실행해주세요:"
  echo ""
  echo "   bash <(curl -sL https://raw.githubusercontent.com/hanui-o/claude-settings/main/setup.sh)"
  echo ""
  exit 1
fi

# ──────────────────────────────────────
# 0. 설치 범위 선택
# ──────────────────────────────────────
COMMON_COMMANDS=(dev review commit update prd build test deploy blog)
FRONTEND_COMMANDS=(perf a11y component ui-review refactor optimize)
BACKEND_COMMANDS=(api db migrate seed security api-doc env-check)

COMMON_AGENTS=()
FRONTEND_AGENTS=(code-reviewer test-runner)
BACKEND_AGENTS=(api-reviewer db-reviewer)

COMMON_HOOKS=(pre-commit-lint post-edit-format block-dangerous-commands)
FRONTEND_HOOKS=()
BACKEND_HOOKS=(block-env-commit validate-migration)

echo "어떤 커맨드를 설치할까요?"
echo ""
echo "  1) 프론트엔드  — React 최적화, 접근성, UI 리뷰 등"
echo "  2) 백엔드      — API, DB, 마이그레이션, 보안 점검 등"
echo "  3) 풀스택      — 전부 설치"
echo ""

# 인자로 전달된 경우 바로 사용, 아니면 입력 받기
if [ -n "$1" ]; then
  CHOICE="$1"
else
  printf "> "
  read -r CHOICE
fi

case "$CHOICE" in
  1)
    echo ""
    echo "📦 프론트엔드 설정을 설치합니다..."
    COMMANDS=("${COMMON_COMMANDS[@]}" "${FRONTEND_COMMANDS[@]}")
    AGENTS=("${COMMON_AGENTS[@]}" "${FRONTEND_AGENTS[@]}")
    HOOKS=("${COMMON_HOOKS[@]}" "${FRONTEND_HOOKS[@]}")
    ;;
  2)
    echo ""
    echo "📦 백엔드 설정을 설치합니다..."
    COMMANDS=("${COMMON_COMMANDS[@]}" "${BACKEND_COMMANDS[@]}")
    AGENTS=("${COMMON_AGENTS[@]}" "${BACKEND_AGENTS[@]}")
    HOOKS=("${COMMON_HOOKS[@]}" "${BACKEND_HOOKS[@]}")
    ;;
  3)
    echo ""
    echo "📦 풀스택 설정을 설치합니다..."
    COMMANDS=("${COMMON_COMMANDS[@]}" "${FRONTEND_COMMANDS[@]}" "${BACKEND_COMMANDS[@]}")
    AGENTS=("${COMMON_AGENTS[@]}" "${FRONTEND_AGENTS[@]}" "${BACKEND_AGENTS[@]}")
    HOOKS=("${COMMON_HOOKS[@]}" "${FRONTEND_HOOKS[@]}" "${BACKEND_HOOKS[@]}")
    ;;
  *)
    echo "❌ 1, 2, 3 중 하나를 선택하세요."
    exit 1
    ;;
esac

echo ""

# ──────────────────────────────────────
# 1. 슬래시 커맨드
# ──────────────────────────────────────
echo "📂 커맨드 설치..."
mkdir -p "$TARGET_DIR/commands"

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
if [ ${#AGENTS[@]} -gt 0 ]; then
  echo ""
  echo "🤖 에이전트 설치..."
  mkdir -p "$TARGET_DIR/agents"

  for agent in "${AGENTS[@]}"; do
    if [ -f "$TARGET_DIR/agents/$agent.md" ]; then
      echo "  ⏭ agents/$agent.md (이미 존재, 스킵)"
    else
      curl -sL "$REPO_URL/agents/$agent.md" -o "$TARGET_DIR/agents/$agent.md"
      echo "  ✅ agents/$agent.md"
    fi
  done
fi

# ──────────────────────────────────────
# 3. 훅 스크립트
# ──────────────────────────────────────
echo ""
echo "🪝 훅 스크립트 설치..."
mkdir -p "$TARGET_DIR/hooks"

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
if [ ${#AGENTS[@]} -gt 0 ]; then
  echo ""
  echo "설치된 에이전트:"
  for agent in "${AGENTS[@]}"; do
    echo "  🤖 $agent"
  done
fi
echo ""
echo "설치된 훅 (활성화하려면 .claude/settings.json에 등록하세요):"
for hook in "${HOOKS[@]}"; do
  echo "  🪝 $hook"
done
