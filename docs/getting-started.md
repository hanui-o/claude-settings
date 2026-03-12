# Claude Code 시작하기

Claude Code 설치부터 MCP 연결까지, 처음 세팅하는 분을 위한 가이드입니다.

> 관련 문서: [확장 기능 이해하기](./features-overview.md) · [메인 README](../README.md)

---

## 1. Claude Code CLI 설치

터미널에서 Claude와 대화하며 코딩하는 CLI 도구입니다.

### 방법 A: 네이티브 설치 (권장)

Node.js 없이 독립 실행파일로 설치됩니다. 자동 업데이트도 지원합니다.

**macOS / Linux:**

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**Windows (PowerShell):**

```powershell
irm https://claude.ai/install.ps1 | iex
```

설치 확인:

```bash
claude --version
```

### 방법 B: npm 설치

Node.js 환경이 이미 있다면 npm으로도 설치할 수 있습니다.

**요구사항:** Node.js 18+

```bash
npm install -g @anthropic-ai/claude-code
```

> **주의:** `sudo npm install -g`는 사용하지 마세요. 권한 문제가 생길 수 있습니다.

### 첫 실행 및 로그인

```bash
claude
```

브라우저가 열리면 Anthropic 계정으로 로그인합니다. Pro, Max, Teams, Enterprise 플랜이 필요합니다.

---

## 2. Claude Code for VS Code 설치

VS Code 안에서 바로 Claude Code를 사용할 수 있는 확장입니다.

[VS Code 설치 가이드](https://code.claude.com/docs/ko/vs-code)

![VS Code 설치 가이드](https://mintcdn.com/claude-code/-YhHHmtSxwr7W8gy/images/vs-code-extension-interface.jpg?w=2500&fit=max&auto=format&n=-YhHHmtSxwr7W8gy&q=85&s=08c92eedfb56fe61a61e480fb63784b6)

### 설치

**방법 1:** VS Code 열고 → `Cmd+Shift+X` (Mac) / `Ctrl+Shift+X` (Windows) → "Claude Code" 검색 → Install

**방법 2:** Command Palette (`Cmd+Shift+P`) → "Install Extensions" → "Claude Code" 검색

### 요구사항

- VS Code **1.98.0** 이상
- Anthropic 계정 (Pro, Max, Teams, Enterprise)
- Windows의 경우 WSL2 또는 Git Bash 필요

### 사용법

설치 후 Claude Code를 여는 방법은 세 가지입니다:

| 방법            | 설명                                           |
| --------------- | ---------------------------------------------- |
| 상태바          | 하단 우측 "✱ Claude Code" 클릭                 |
| 에디터 툴바     | 파일 열린 상태에서 우측 상단 Spark 아이콘 클릭 |
| Command Palette | `Cmd+Shift+P` → "Claude Code" 입력             |

### 주요 단축키

| 단축키          | 기능                        |
| --------------- | --------------------------- |
| `Cmd+Esc`       | 에디터 ↔ Claude 포커스 전환 |
| `Cmd+Shift+Esc` | 새 대화 탭 열기             |
| `Option+K`      | @멘션 참조 삽입             |
| `Shift+Enter`   | 줄바꿈 (전송하지 않음)      |

> Windows에서는 `Cmd` 대신 `Ctrl`, `Option` 대신 `Alt`을 사용합니다.

### VS Code 설정

`Cmd+,` → Extensions → Claude Code에서 설정할 수 있습니다.

| 설정                 | 기본값    | 설명                             |
| -------------------- | --------- | -------------------------------- |
| `selectedModel`      | `default` | 사용할 모델                      |
| `preferredLocation`  | `panel`   | Claude 패널 위치 (sidebar/panel) |
| `autosave`           | `true`    | 파일 읽기/쓰기 전 자동 저장      |
| `useCtrlEnterToSend` | `false`   | Ctrl+Enter로 전송 (Enter 줄바꿈) |

---

## 3. Claude MCP 연결하기

MCP(Model Context Protocol)는 Claude에 외부 도구를 연결하는 표준입니다. GitHub, Notion, DB, Sentry 등 다양한 서비스를 Claude 안에서 직접 사용할 수 있습니다.

### Claude Desktop에서 연결 (가장 쉬운 방법)

1. [Claude Desktop](https://claude.ai/download) 설치 및 실행
2. **Settings** → **Connections** 이동
3. 연결하려는 서비스 찾기 → **Connect** 클릭
4. 브라우저에서 인증 완료

연결된 MCP 서버는 Claude Desktop과 Claude Code 모두에서 사용할 수 있습니다.

### Claude Code CLI에서 연결

#### 리모트 서버 (클라우드 서비스)

```bash
# HTTP 방식 (권장)
claude mcp add --transport http <이름> <URL>

# 예시
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
claude mcp add --transport http notion https://mcp.notion.com/mcp
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

인증이 필요한 서버는 추가 후 Claude Code에서 `/mcp` 입력 → 브라우저 인증을 따릅니다.

#### 로컬 서버 (직접 실행)

```bash
claude mcp add --transport stdio <이름> -- <명령어> [인자...]

# 예시: PostgreSQL 연결
claude mcp add --transport stdio db -- npx -y @bytebase/dbhub \
  --dsn "postgresql://user:pass@localhost:5432/mydb"

# 예시: Airtable
claude mcp add --transport stdio airtable --env AIRTABLE_API_KEY=YOUR_KEY \
  -- npx -y airtable-mcp-server
```

#### Claude Desktop 서버 가져오기

Claude Desktop에서 이미 설정한 MCP 서버를 Claude Code로 한 번에 가져올 수 있습니다:

```bash
claude mcp add-from-claude-desktop
```

### MCP 관리 명령어

```bash
claude mcp list              # 연결된 서버 목록
claude mcp get <이름>         # 서버 상세 정보
claude mcp remove <이름>      # 서버 제거
```

Claude Code 안에서는 `/mcp`로 상태를 확인할 수 있습니다.

### 설정 파일

MCP 서버 설정은 JSON 파일로 관리됩니다.

| 범위                             | 파일 위치                   | 용도                     |
| -------------------------------- | --------------------------- | ------------------------ |
| **프로젝트** (팀 공유)           | `.mcp.json` (프로젝트 루트) | Git에 커밋, 팀 전체 공유 |
| **사용자** (개인, 전체 프로젝트) | `~/.claude.json`            | 모든 프로젝트에서 사용   |

#### .mcp.json 예시

프로젝트 루트에 `.mcp.json`을 만들면 팀 전체가 같은 MCP 서버를 사용할 수 있습니다:

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/"
    },
    "database": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@bytebase/dbhub", "--dsn", "postgresql://localhost/mydb"],
      "env": {
        "DB_PASSWORD": "${DB_PASSWORD}"
      }
    }
  }
}
```

> `${변수명}` 문법으로 환경 변수를 참조할 수 있습니다. 시크릿은 `.env`에 두고 참조하세요.

---

## 요약: 뭘 설치해야 하나요?

| 상황                           | 설치할 것                                 |
| ------------------------------ | ----------------------------------------- |
| 터미널에서 CLI로 사용하고 싶다 | Claude Code CLI (네이티브 설치)           |
| VS Code 안에서 사용하고 싶다   | Claude Code for VS Code 확장              |
| 외부 서비스를 연결하고 싶다    | Claude Desktop에서 Connections로 MCP 연결 |
| 전부 다                        | 셋 다 설치 (서로 연동됩니다)              |
