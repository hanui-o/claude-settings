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

| 커맨드 | 설명 |
|--------|------|
| `/dev` | 개발 서버 실행 |
| `/build` | 빌드 실행 + 에러 자동 수정 |
| `/review` | 변경된 코드 리뷰 |
| `/commit` | Conventional Commits 형식으로 커밋 |
| `/update` | 커밋 + main rebase 동기화 |
| `/prd` | PR 설명 자동 생성 |
| `/perf` | 성능 이슈 점검 |
| `/a11y` | 접근성 검사 |

## 구조

```
claude-settings/
├── commands/          ← 슬래시 커맨드 (.claude/commands/ 에 복사)
│   ├── dev.md
│   ├── build.md
│   ├── review.md
│   ├── commit.md
│   ├── update.md
│   ├── prd.md
│   ├── perf.md
│   └── a11y.md
├── CLAUDE.md.template ← 프로젝트용 CLAUDE.md 템플릿
└── setup.sh           ← 설치 스크립트
```

## 커스터마이징

각 커맨드 파일은 마크다운이므로 프로젝트에 맞게 자유롭게 수정하세요.

## 기여

새로운 커맨드나 개선 사항은 PR로 보내주세요!
