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

여기에 실무에서 자주 쓰는 **Git 워크플로우**(`/commit`, `/update`), **빌드**(`/build`, `/dev`), **코드 리뷰**(`/review`), **테스트**(`/test`), **PR 설명 생성**(`/prd`) 커맨드와 **백엔드 개발**(`/api`, `/db`, `/migrate`, `/seed`, `/security`, `/api-doc`, `/env-check`) 커맨드를 추가했습니다.

### 커맨드 vs 에이전트 vs 훅

| | 커맨드 | 에이전트 | 훅 |
|---|---|---|---|
| **실행** | `/명령어`로 직접 호출 | Claude가 자동 위임 또는 직접 요청 | 이벤트 발생 시 자동 실행 |
| **역할** | 정해진 작업 수행 | 복잡한 작업을 독립 컨텍스트에서 수행 | 단순 검증/자동화 (통과 or 차단) |
| **비유** | 도구 | 일을 대신 해주는 동료 | 자동으로 걸리는 안전장치 |
| **예시** | `/commit` → 커밋 | "리뷰해줘" → code-reviewer 작동 | 파일 저장 → Prettier 자동 실행 |

---

## 문서

| 문서 | 설명 |
|------|------|
| [Claude Code 시작하기](docs/getting-started.md) | CLI 설치, VS Code 확장, MCP 연결 방법 |
| [확장 기능 이해하기](docs/features-overview.md) | CLAUDE.md, Skill, Subagent, MCP, Hook 비교 및 조합 패턴 |

---

## 설치

### 방법 1: 원라인 설치

프로젝트 루트에서 실행하세요. 프론트엔드/백엔드/풀스택 중 선택할 수 있습니다.

```bash
bash <(curl -sL https://raw.githubusercontent.com/hanui-o/claude-settings/main/setup.sh)

# 어떤 커맨드를 설치할까요?
#   1) 프론트엔드  — React 최적화, 접근성, UI 리뷰 등
#   2) 백엔드      — API, DB, 마이그레이션, 보안 점검 등
#   3) 풀스택      — 전부 설치
# >
```

인자로 바로 선택할 수도 있습니다: `bash <(curl -sL ...) 2` (백엔드)

| 선택 | 커맨드 | 에이전트 | 훅 |
|------|--------|----------|-----|
| 1) 프론트엔드 | 공통 9 + 프론트 6 = 15종 | 2종 | 3종 |
| 2) 백엔드 | 공통 9 + 백엔드 7 = 16종 | 2종 | 5종 |
| 3) 풀스택 | 공통 9 + 프론트 6 + 백엔드 7 = 22종 | 4종 | 5종 |

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
# 프론트엔드
> /commit                    # Conventional Commits 형식으로 커밋
> /component Button          # Button 컴포넌트 보일러플레이트 생성
> /optimize src/components/  # React 성능 최적화 점검

# 백엔드
> /api users                 # users CRUD API 엔드포인트 생성
> /db posts: title, content  # posts 테이블 스키마/마이그레이션 생성
> /security src/routes/      # 백엔드 보안 취약점 점검
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

### 공통 (9종)

모든 설치 옵션에 포함됩니다.

| 커맨드 | 설명 |
|--------|------|
| `/dev` | 패키지 매니저 감지 → 의존성 설치 → 개발 서버 실행 |
| `/build` | 빌드 실행, 에러 발생 시 자동 수정 후 재시도 |
| `/commit` | main 브랜치 보호, Conventional Commits 한 줄 커밋 |
| `/update` | 커밋 + `git fetch origin main` + `git rebase origin/main` |
| `/deploy [target]` | Vercel/Netlify/Firebase 자동 감지, preview가 기본값 |
| `/review` | 타입 안전성, 성능, 보안, 접근성 관점 코드 리뷰 |
| `/test {file\|"run"}` | 테스트 작성 (AAA 패턴, 한국어 설명) 또는 실행 |
| `/prd` | 브랜치 변경사항 분석 → PR 설명 마크다운 생성 |
| `/blog` | 블로그 글 작성 또는 velog 이전 (mdx + 이전 공지 자동 생성) |

### 프론트엔드 (6종)

설치 옵션 1) 프론트엔드, 3) 풀스택에 포함됩니다.

| 커맨드 | 설명 |
|--------|------|
| `/component {name}` | 프로젝트 패턴 감지 후 컴포넌트 파일 생성 |
| `/refactor [file]` | Boolean prop 정리, Compound Component, 관심사 분리 제안 |
| `/optimize [path]` | 번들 최적화, 리렌더 방지, waterfall 제거, 심각도별 정렬 |
| `/perf` | 렌더링, 메모리, 네트워크/에셋, 이벤트 핸들링 점검 |
| `/a11y` | 시맨틱 HTML, ARIA, 키보드 접근성, 색상 대비 검사 |
| `/ui-review [file]` | 레이아웃, 인터랙션, 타이포그래피, 색상, 상태 처리 리뷰 |

### 백엔드 (7종)

설치 옵션 2) 백엔드, 3) 풀스택에 포함됩니다.

| 커맨드 | 설명 |
|--------|------|
| `/api {resource}` | CRUD API 엔드포인트 생성 (Express, Fastify, NestJS, Spring Boot 등 자동 감지) |
| `/db {table: fields}` | DB 스키마/모델 + 마이그레이션 파일 생성 (Prisma, TypeORM, Drizzle 등 자동 감지) |
| `/migrate [action]` | DB 마이그레이션 실행/상태확인/롤백/생성 |
| `/seed [table\|"run"]` | 한국어 시드 데이터 생성 또는 실행 |
| `/security [path]` | SQL Injection, 인증 우회, XSS 등 OWASP 기준 보안 점검 |
| `/api-doc [path]` | API 라우트 탐색 → 마크다운 API 문서 자동 생성 |
| `/env-check` | `.env` 누락/불일치/보안 위험 검증 |

---

## 에이전트

### 프론트엔드

| 에이전트 | 설명 | 모델 |
|----------|------|------|
| `code-reviewer` | 변경된 코드의 타입 안전성, 성능, 보안, 접근성을 심각도별로 리뷰 | Sonnet |
| `test-runner` | 변경된 파일과 관련된 테스트를 자동 탐색·실행, 실패 시 원인 분석 | Sonnet |

### 백엔드

| 에이전트 | 설명 | 모델 |
|----------|------|------|
| `api-reviewer` | API 코드의 보안(SQL Injection, 인증), 성능(N+1), REST 규칙 리뷰 | Sonnet |
| `db-reviewer` | DB 스키마, 쿼리, 마이그레이션의 성능과 안전성 리뷰 | Sonnet |

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

### 공통

| 훅 | 이벤트 | 설명 |
|----|--------|------|
| `pre-commit-lint.sh` | PreToolUse (Bash) | `git commit` 실행 전 lint 자동 체크, 실패 시 커밋 차단 |
| `post-edit-format.sh` | PostToolUse (Edit\|Write) | 파일 수정 후 Prettier 자동 포맷팅 |
| `block-dangerous-commands.sh` | PreToolUse (Bash) | `rm -rf`, `force push main` 등 위험 명령어 차단 |

### 백엔드

| 훅 | 이벤트 | 설명 |
|----|--------|------|
| `block-env-commit.sh` | PreToolUse (Bash) | `.env` 파일 커밋 차단, `git add -A` 시 .gitignore 검증 |
| `validate-migration.sh` | PostToolUse (Edit\|Write) | 마이그레이션 파일의 DROP TABLE, CASCADE 등 위험 패턴 감지 |

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
          },
          {
            "type": "command",
            "command": "./.claude/hooks/block-env-commit.sh"
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
          },
          {
            "type": "command",
            "command": "./.claude/hooks/validate-migration.sh"
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
│   ├── [공통]
│   │   ├── dev.md                     ← 개발 서버
│   │   ├── build.md                   ← 빌드 + 에러 자동 수정
│   │   ├── commit.md                  ← Conventional Commits 커밋
│   │   ├── update.md                  ← 커밋 + rebase
│   │   ├── deploy.md                  ← 배포 자동화
│   │   ├── review.md                  ← 코드 리뷰
│   │   ├── test.md                    ← 테스트 작성/실행
│   │   ├── prd.md                     ← PR 설명 생성
│   │   └── blog.md                    ← 블로그 글 작성/이전
│   ├── [프론트엔드]
│   │   ├── component.md               ← 컴포넌트 생성
│   │   ├── refactor.md                ← 리팩토링 제안
│   │   ├── optimize.md                ← React 성능 최적화
│   │   ├── perf.md                    ← 일반 성능 점검
│   │   ├── a11y.md                    ← 접근성 검사
│   │   └── ui-review.md              ← UI 디자인 리뷰
│   └── [백엔드]
│       ├── api.md                     ← API 엔드포인트 생성
│       ├── db.md                      ← DB 스키마/마이그레이션 생성
│       ├── migrate.md                 ← DB 마이그레이션 실행
│       ├── seed.md                    ← 시드 데이터 생성/실행
│       ├── security.md                ← 백엔드 보안 점검
│       ├── api-doc.md                 ← API 문서 생성
│       └── env-check.md               ← 환경변수 검증
├── agents/                            ← 에이전트 (→ .claude/agents/)
│   ├── [프론트엔드]
│   │   ├── code-reviewer.md           ← 코드 리뷰 에이전트
│   │   └── test-runner.md             ← 테스트 실행 에이전트
│   └── [백엔드]
│       ├── api-reviewer.md            ← API 코드 리뷰 에이전트
│       └── db-reviewer.md             ← DB 스키마/쿼리 리뷰 에이전트
├── hooks/                             ← 훅 스크립트 (→ .claude/hooks/)
│   ├── [공통]
│   │   ├── pre-commit-lint.sh         ← 커밋 전 lint
│   │   ├── post-edit-format.sh        ← 수정 후 포맷팅
│   │   └── block-dangerous-commands.sh ← 위험 명령어 차단
│   └── [백엔드]
│       ├── block-env-commit.sh        ← .env 파일 커밋 차단
│       └── validate-migration.sh      ← 마이그레이션 위험 패턴 감지
├── CLAUDE.md.template                 ← 프로젝트용 CLAUDE.md 템플릿
└── setup.sh                           ← 설치 스크립트 (프론트/백엔드/풀스택 선택)
```

> 참고: 실제 파일은 하위 폴더 없이 `commands/`, `agents/`, `hooks/`에 플랫하게 위치합니다. 위 분류는 설치 옵션에 따른 구분을 보여주기 위한 것입니다.

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
