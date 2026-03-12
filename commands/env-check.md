환경변수 설정을 검증해줘.

## 절차

1. 환경변수 관련 파일을 확인한다
   - `.env`, `.env.example`, `.env.local`, `.env.development`, `.env.production`
   - 프레임워크별 설정 (next.config, application.yml, settings.py 등)

2. `.env.example`과 실제 `.env`를 비교한다
   - `.env`에 없는데 `.env.example`에 있는 변수 → **누락 경고**
   - `.env`에 있는데 `.env.example`에 없는 변수 → **example 업데이트 필요**
   - 값이 비어 있는 필수 변수 → **설정 필요 경고**

3. 코드에서 사용하는 환경변수를 탐색한다
   - `process.env.`, `os.environ`, `System.getenv()` 등
   - `.env`에 정의되지 않은 환경변수 사용 → **정의 누락 경고**

4. 보안 점검
   - `.gitignore`에 `.env`가 포함되어 있는지 확인
   - 환경변수에 민감 정보가 기본값으로 들어가 있는지 확인
   - 프론트엔드에 노출되면 안 되는 변수 확인 (NEXT_PUBLIC_, VITE_ 접두사)

5. 결과를 요약한다

## 출력 형식

```
✅ .env 파일 존재
✅ .gitignore에 .env 포함
⚠️  누락된 변수: REDIS_URL (.env.example에 정의됨)
⚠️  example 미반영: SENTRY_DSN (.env에만 존재)
❌ 코드에서 사용하지만 미정의: SMTP_HOST (src/mailer.ts:12)
❌ 프론트엔드 노출 위험: NEXT_PUBLIC_SECRET_KEY
```
