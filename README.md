# claude-settings

Claude Code 커맨드 & 설정 모음. 새 프로젝트에 바로 적용할 수 있습니다.

## 설치

### 방법 1: 원라인 설치

```bash
bash <(curl -sL https://raw.githubusercontent.com/hanui-o/claude-settings/main/setup.sh)
```

### 방법 2: 수동 복사

```bash
# 레포 클론
git clone https://github.com/hanui-o/claude-settings.git /tmp/claude-settings

# 커맨드 복사
mkdir -p .claude/commands
cp /tmp/claude-settings/commands/*.md .claude/commands/

# 정리
rm -rf /tmp/claude-settings
```

## 커맨드 목록

### 기본

| 커맨드 | 설명 |
|--------|------|
| `/dev` | 개발 서버 실행 |
| `/build` | 빌드 실행 + 에러 자동 수정 |
| `/commit` | Conventional Commits 형식으로 커밋 |
| `/update` | 커밋 + main rebase 동기화 |
| `/deploy` | 배포 자동화 (Vercel, Netlify 등 자동 감지) |

### 코드 품질

| 커맨드 | 설명 |
|--------|------|
| `/review` | 변경된 코드 리뷰 |
| `/refactor` | React 컴포지션 패턴 기반 리팩토링 제안 |
| `/optimize` | React 성능 최적화 점검 (번들, 리렌더, 메모이제이션) |
| `/perf` | 일반 성능 이슈 점검 |
| `/a11y` | 접근성 검사 |
| `/ui-review` | 웹 디자인 가이드라인 기반 UI 리뷰 |

### 생성

| 커맨드 | 설명 |
|--------|------|
| `/component {name}` | 새 컴포넌트 보일러플레이트 생성 |
| `/test {file}` | 테스트 작성 및 실행 |
| `/prd` | PR 설명 자동 생성 |

## 구조

```
claude-settings/
├── commands/          ← 슬래시 커맨드 (.claude/commands/ 에 복사)
│   ├── dev.md         ← 개발 서버
│   ├── build.md       ← 빌드
│   ├── commit.md      ← 커밋
│   ├── update.md      ← 커밋 + rebase
│   ├── deploy.md      ← 배포
│   ├── review.md      ← 코드 리뷰
│   ├── refactor.md    ← 리팩토링
│   ├── optimize.md    ← React 성능 최적화
│   ├── perf.md        ← 일반 성능 점검
│   ├── a11y.md        ← 접근성
│   ├── ui-review.md   ← UI 디자인 리뷰
│   ├── component.md   ← 컴포넌트 생성
│   ├── test.md        ← 테스트
│   └── prd.md         ← PR 설명 생성
├── CLAUDE.md.template ← 프로젝트용 CLAUDE.md 템플릿
└── setup.sh           ← 설치 스크립트
```

## 커스터마이징

각 커맨드 파일은 마크다운이므로 프로젝트에 맞게 자유롭게 수정하세요.

## 기여

새로운 커맨드나 개선 사항은 PR로 보내주세요!
