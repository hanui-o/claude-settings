# claude-settings

Claude Code 슬래시 커맨드, 에이전트, 훅 설정 모음. 새 프로젝트에 바로 적용할 수 있습니다.

[vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills)는 Vercel이 공개한 AI 코딩 에이전트용 스킬 패키지 모음으로, React/Next.js 성능 최적화(40+ 규칙), 웹 디자인 가이드라인(100+ 규칙), 컴포지션 패턴, 배포 자동화 등의 가이드라인을 담고 있습니다. 이 레포는 해당 가이드라인을 **Claude Code 전용 슬래시 커맨드·에이전트·훅** 형태로 재구성한 것입니다.

### 어떤 가이드라인이 반영되어 있나요?

| 원본 스킬 (agent-skills) | 반영된 커맨드 |
|--------------------------|---------------|
| **react-best-practices** — React/Next.js 성능 최적화 40+ 규칙 | `/optimize`, `/perf` |
| **web-design-guidelines** — UI 접근성·성능·UX 100+ 규칙 | `/ui-review`, `/a11y` |
| **composition-patterns** — React 컴포지션 패턴 가이드 | `/refactor`, `/component` |
| **vercel-deploy-claimable** — 배포 자동화 | `/deploy` |

여기에 실무에서 자주 쓰는 **Git 워크플로우**(`/commit`, `/update`), **빌드**(`/build`, `/dev`), **코드 리뷰**(`/review`), **테스트**(`/test`), **PR 설명 생성**(`/prd`) 커맨드를 추가했습니다.

### 커맨드 vs 에이전트 vs 훅

| | 커맨드 | 에이전트 | 훅 |
|---|---|---|---|
| **실행** | `/명령어`로 직접 호출 | Claude가 자동 위임 또는 직접 요청 | 이벤트 발생 시 자동 실행 |
| **역할** | 정해진 작업 수행 | 복잡한 작업을 독립 컨텍스트에서 수행 | 단순 검증/자동화 (통과 or 차단) |
| **비유** | 도구 | 일을 대신 해주는 동료 | 자동으로 걸리는 안전장치 |
| **예시** | `/commit` → 커밋 | "리뷰해줘" → code-reviewer 작동 | 파일 저장 → Prettier 자동 실행 |

---

## 설치

### 방법 1: 원라인 설치

프로젝트 루트에서 실행하세요.

```bash
bash <(curl -sL https://raw.githubusercontent.com/hanui-o/claude-settings/main/setup.sh)
```

이 스크립트는:
- `.claude/commands/` — 슬래시 커맨드 14종
- `.claude/agents/` — 에이전트 2종
- `.claude/hooks/` — 훅 스크립트 3종
- `CLAUDE.md` — 프로젝트 설정 템플릿 (없을 때만)

이미 존재하는 파일은 덮어쓰지 않습니다.

### 방법 2: 수동 복사

```bash
git clone https://github.com/hanui-o/claude-settings.git /tmp/claude-settings

mkdir -p .claude/commands .claude/agents .claude/hooks
cp /tmp/claude-settings/commands/*.md .claude/commands/
cp /tmp/claude-settings/agents/*.md .claude/agents/
cp /tmp/claude-settings/hooks/*.sh .claude/hooks/
chmod +x .claude/hooks/*.sh

rm -rf /tmp/claude-settings
```

### 설치 후 할 일

1. **`CLAUDE.md` 수정** — 프로젝트의 기술 스택, 빌드 명령어, 컨벤션을 채워넣으세요
2. **훅 활성화** — 사용할 훅을 `.claude/settings.json`에 등록하세요 ([훅 설정 방법](#훅-설정-방법) 참고)
3. **커스터마이징** — 각 파일은 마크다운/쉘스크립트이므로 프로젝트에 맞게 수정하세요

---

## 사용법

### 슬래시 커맨드

Claude Code에서 `/`를 입력하면 설치된 커맨드 목록이 나타납니다.

```
> /commit                    # Conventional Commits 형식으로 커밋
> /deploy preview            # Vercel/Netlify 등 자동 감지 후 프리뷰 배포
> /test src/utils/calc.ts    # 해당 파일의 테스트 작성 및 실행
> /component Button          # Button 컴포넌트 보일러플레이트 생성
> /review                    # 변경된 코드 리뷰
> /optimize src/components/  # React 성능 최적화 점검
```

인자가 필요한 커맨드는 뒤에 이어서 입력합니다.

### 에이전트

에이전트는 Claude가 작업 중 **자동으로 위임**하거나, 직접 요청할 수 있습니다.

```
> code-reviewer 에이전트로 이번 변경사항 리뷰해줘
> 테스트 돌려줘    ← test-runner 에이전트가 자동 위임됨
```

커맨드와 달리 에이전트는 **독립된 컨텍스트**에서 실행되므로 메인 대화에 영향을 주지 않습니다.

### 훅

훅은 `.claude/settings.json`에 등록하면 **이벤트 발생 시 자동 실행**됩니다. 슬래시 커맨드처럼 수동 호출하는 것이 아닙니다.

---

## 커맨드 목록

### 기본

| 커맨드 | 설명 |
|--------|------|
| `/dev` | 패키지 매니저 감지 → 의존성 설치 → 개발 서버 실행 |
| `/build` | 빌드 실행, 에러 발생 시 자동 수정 후 재시도 |
| `/commit` | main 브랜치 보호, Conventional Commits 한 줄 커밋 |
| `/update` | 커밋 + `git fetch origin main` + `git rebase origin/main` |
| `/deploy [target]` | Vercel/Netlify/Firebase 자동 감지, preview가 기본값 |

### 코드 품질

| 커맨드 | 설명 |
|--------|------|
| `/review` | 타입 안전성, 성능, 보안, 접근성 관점 코드 리뷰 |
| `/refactor [file]` | Boolean prop 정리, Compound Component, 관심사 분리 제안 |
| `/optimize [path]` | 번들 최적화, 리렌더 방지, waterfall 제거, 심각도별 정렬 |
| `/perf` | 렌더링, 메모리, 네트워크/에셋, 이벤트 핸들링 점검 |
| `/a11y` | 시맨틱 HTML, ARIA, 키보드 접근성, 색상 대비 검사 |
| `/ui-review [file]` | 레이아웃, 인터랙션, 타이포그래피, 색상, 상태 처리 리뷰 |

### 생성

| 커맨드 | 설명 |
|--------|------|
| `/component {name}` | 프로젝트 패턴 감지 후 컴포넌트 파일 생성 |
| `/test {file\|"run"}` | 테스트 작성 (AAA 패턴, 한국어 설명) 또는 실행 |
| `/prd` | 브랜치 변경사항 분석 → PR 설명 마크다운 생성 |

---

## 에이전트

| 에이전트 | 설명 | 모델 |
|----------|------|------|
| `code-reviewer` | 변경된 코드의 타입 안전성, 성능, 보안, 접근성을 심각도별로 리뷰 | Sonnet |
| `test-runner` | 변경된 파일과 관련된 테스트를 자동 탐색·실행, 실패 시 원인 분석 | Sonnet |

에이전트 파일은 `.claude/agents/`에 위치하며, YAML frontmatter로 설정합니다.

```yaml
---
name: code-reviewer
description: PR 제출 전 코드 리뷰를 자동 수행
tools: Read, Grep, Glob, Bash    # 사용 가능한 도구 제한
model: sonnet                     # 사용 모델
---
```

---

## 훅

| 훅 | 이벤트 | 설명 |
|----|--------|------|
| `pre-commit-lint.sh` | PreToolUse (Bash) | `git commit` 실행 전 lint 자동 체크, 실패 시 커밋 차단 |
| `post-edit-format.sh` | PostToolUse (Edit\|Write) | 파일 수정 후 Prettier 자동 포맷팅 |
| `block-dangerous-commands.sh` | PreToolUse (Bash) | `rm -rf`, `force push main` 등 위험 명령어 차단 |

### 훅 설정 방법

훅은 설치만으로 작동하지 않습니다. `.claude/settings.json`에 등록해야 활성화됩니다.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "./.claude/hooks/block-dangerous-commands.sh"
          },
          {
            "type": "command",
            "command": "./.claude/hooks/pre-commit-lint.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "./.claude/hooks/post-edit-format.sh"
          }
        ]
      }
    ]
  }
}
```

필요한 훅만 골라서 등록하세요. 전부 등록할 필요 없습니다.

---

## 구조

```
claude-settings/
├── commands/                          ← 슬래시 커맨드 (→ .claude/commands/)
│   ├── dev.md                         ← 개발 서버
│   ├── build.md                       ← 빌드 + 에러 자동 수정
│   ├── commit.md                      ← Conventional Commits 커밋
│   ├── update.md                      ← 커밋 + rebase
│   ├── deploy.md                      ← 배포 자동화
│   ├── review.md                      ← 코드 리뷰
│   ├── refactor.md                    ← 리팩토링 제안
│   ├── optimize.md                    ← React 성능 최적화
│   ├── perf.md                        ← 일반 성능 점검
│   ├── a11y.md                        ← 접근성 검사
│   ├── ui-review.md                   ← UI 디자인 리뷰
│   ├── component.md                   ← 컴포넌트 생성
│   ├── test.md                        ← 테스트 작성/실행
│   └── prd.md                         ← PR 설명 생성
├── agents/                            ← 에이전트 (→ .claude/agents/)
│   ├── code-reviewer.md               ← 코드 리뷰 에이전트
│   └── test-runner.md                 ← 테스트 실행 에이전트
├── hooks/                             ← 훅 스크립트 (→ .claude/hooks/)
│   ├── pre-commit-lint.sh             ← 커밋 전 lint
│   ├── post-edit-format.sh            ← 수정 후 포맷팅
│   └── block-dangerous-commands.sh    ← 위험 명령어 차단
├── CLAUDE.md.template                 ← 프로젝트용 CLAUDE.md 템플릿
└── setup.sh                           ← 설치 스크립트
```

---

## 커스터마이징

모든 파일은 마크다운 또는 쉘스크립트이므로 자유롭게 수정할 수 있습니다.

- **커맨드 수정**: `.claude/commands/commit.md`를 열어 커밋 규칙을 팀 컨벤션에 맞게 변경
- **커맨드 추가**: `.claude/commands/my-command.md`를 만들면 `/my-command`로 사용 가능
- **에이전트 추가**: `.claude/agents/my-agent.md`를 만들면 자동 인식
- **훅 추가**: 스크립트 작성 후 `.claude/settings.json`에 등록
- **삭제**: 사용하지 않는 파일을 삭제하면 끝

## Credits

- [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) — React 성능 최적화, 웹 디자인 가이드라인, 컴포지션 패턴, 배포 자동화 스킬의 원본 가이드라인

## 기여

새로운 커맨드나 개선 사항은 PR로 보내주세요!
