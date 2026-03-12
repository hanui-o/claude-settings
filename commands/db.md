DB 스키마 또는 마이그레이션 파일을 생성해줘.

## 인자

- `$ARGUMENTS`: 테이블/모델 이름과 필드 설명 (예: "users: name, email, password, role")

## 절차

1. 프로젝트의 DB 도구를 감지한다
   - ORM: Prisma, TypeORM, Sequelize, Drizzle, JPA, SQLAlchemy, Django ORM
   - 마이그레이션: Knex, Flyway, Alembic, Django migrations
   - 직접 SQL 사용 여부

2. 기존 스키마/모델 패턴을 확인한다
   - 파일 위치 (models/, entities/, prisma/schema.prisma 등)
   - 네이밍 규칙 (단수/복수, camelCase/snake_case)
   - 공통 필드 (id, createdAt, updatedAt, deletedAt 등)
   - 소프트 삭제 패턴 사용 여부

3. 스키마/모델 파일을 생성한다
   - 적절한 데이터 타입 선택
   - NOT NULL, DEFAULT, UNIQUE 등 제약조건 설정
   - 인덱스 추가 (자주 검색되는 필드)
   - 관계 설정 (1:N, N:M 등)

4. 마이그레이션 파일이 필요한 경우 함께 생성한다

## 출력

- 생성된 파일 목록
- 테이블 구조 요약 (필드, 타입, 제약조건)
- 마이그레이션 실행 명령어 안내
