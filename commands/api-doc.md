API 문서를 생성해줘.

## 인자

- `$ARGUMENTS`: 대상 (파일/디렉토리, 기본값: 전체 API 라우트)

## 절차

1. 프로젝트의 API 라우트를 탐색한다
   - Express: `app.get()`, `router.post()` 등
   - Fastify: `fastify.route()`, 데코레이터
   - NestJS: `@Get()`, `@Post()` 등 데코레이터
   - Spring Boot: `@GetMapping`, `@PostMapping` 등
   - FastAPI: `@app.get()`, `@router.post()` 등

2. 각 엔드포인트의 정보를 수집한다
   - HTTP 메서드, 경로
   - 요청 파라미터 (path, query, body)
   - 요청/응답 타입 (TypeScript 타입, DTO, 스키마)
   - 인증 필요 여부 (미들웨어, 가드, 데코레이터)
   - 에러 응답

3. 마크다운 API 문서를 생성한다

## 출력 형식

```markdown
# API 문서

## 인증
- Bearer Token (Authorization 헤더)

## 엔드포인트

### 사용자

#### POST /api/auth/login
로그인

**Request Body**
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| email | string | ✅ | 이메일 |
| password | string | ✅ | 비밀번호 |

**Response 200**
```json
{ "token": "eyJ...", "user": { "id": 1, "email": "..." } }
```

**Error**
- 401: 이메일 또는 비밀번호 불일치
- 429: 로그인 시도 초과
```

4. 파일로 저장한다 (`docs/api.md` 또는 프로젝트 관례에 따라)

## 주의

- 기존 Swagger/OpenAPI 설정이 있으면 그 형식을 따른다
- 내부 전용 엔드포인트는 별도로 표시한다
