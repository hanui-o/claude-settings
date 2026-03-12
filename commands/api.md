API 엔드포인트를 생성해줘.

## 인자

- `$ARGUMENTS`: 리소스 이름 (예: users, posts, products)

## 절차

1. 프로젝트 구조를 파악한다
   - Express, Fastify, NestJS, Spring Boot, Django, FastAPI 등 프레임워크 감지
   - 기존 API 패턴 확인 (라우터 구조, 컨트롤러 패턴, 미들웨어)
   - 인증/인가 미들웨어 확인

2. 기존 패턴에 맞춰 CRUD 엔드포인트를 생성한다
   - `GET /api/{resource}` — 목록 조회 (페이지네이션, 검색, 정렬)
   - `GET /api/{resource}/:id` — 단건 조회
   - `POST /api/{resource}` — 생성
   - `PUT /api/{resource}/:id` — 수정
   - `DELETE /api/{resource}/:id` — 삭제

3. 각 엔드포인트에 포함할 것
   - 입력 유효성 검사 (zod, joi, class-validator 등 프로젝트에서 쓰는 것)
   - 에러 핸들링 (try-catch, 적절한 HTTP 상태 코드)
   - 타입 정의 (TypeScript인 경우)

4. 생성한 파일 목록과 엔드포인트를 요약한다

## 주의

- 기존 프로젝트의 네이밍 컨벤션을 따른다 (camelCase, snake_case 등)
- 이미 존재하는 파일은 덮어쓰지 않는다
- 인증이 필요한 엔드포인트에는 기존 인증 미들웨어를 적용한다
- SQL 쿼리를 직접 작성하는 경우 반드시 파라미터 바인딩을 사용한다 (SQL Injection 방지)
