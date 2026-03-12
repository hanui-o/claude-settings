DB 마이그레이션을 실행해줘.

## 인자

- `$ARGUMENTS`: 실행할 작업 (기본값: "run")
  - `run` — 미적용 마이그레이션 실행
  - `status` — 현재 마이그레이션 상태 확인
  - `rollback` — 마지막 마이그레이션 롤백
  - `generate` — 스키마 변경 감지 후 마이그레이션 파일 생성

## 절차

1. 프로젝트의 마이그레이션 도구를 감지한다
   - Prisma: `npx prisma migrate`
   - TypeORM: `npx typeorm migration:run`
   - Knex: `npx knex migrate`
   - Sequelize: `npx sequelize-cli db:migrate`
   - Drizzle: `npx drizzle-kit`
   - Flyway, Alembic, Django 등

2. 현재 마이그레이션 상태를 확인한다
   - 적용된 마이그레이션 목록
   - 미적용 마이그레이션 존재 여부

3. 요청된 작업을 실행한다
   - `run`: 미적용 마이그레이션을 순서대로 실행
   - `status`: 현재 상태를 테이블로 표시
   - `rollback`: 마지막 마이그레이션을 되돌림 (실행 전 확인 요청)
   - `generate`: 스키마 변경사항을 감지하고 마이그레이션 파일 생성

4. 결과를 요약한다

## 주의

- `rollback`은 실행 전 반드시 사용자에게 확인을 받는다
- 프로덕션 DB에 직접 마이그레이션하지 않는다
- 에러 발생 시 원인을 분석하고 해결 방법을 제시한다
