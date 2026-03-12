백엔드 코드의 보안 취약점을 점검해줘.

## 인자

- `$ARGUMENTS`: 점검 대상 (파일/디렉토리, 기본값: 변경된 파일)

## 점검 항목

### CRITICAL

- **SQL Injection**: 문자열 연결로 쿼리 작성, 파라미터 바인딩 미사용
- **인증 우회**: JWT 검증 누락, 비밀키 하드코딩, 토큰 만료 미설정
- **민감 정보 노출**: .env 파일 커밋, 에러 응답에 스택 트레이스, 로그에 비밀번호/토큰
- **경로 탐색**: 사용자 입력으로 파일 경로 직접 접근 (`../../../etc/passwd`)
- **명령어 주입**: `exec()`, `eval()`, `child_process` 에 사용자 입력 직접 전달

### HIGH

- **XSS**: 사용자 입력을 이스케이프 없이 HTML 출력
- **CSRF**: POST/PUT/DELETE에 CSRF 토큰 미적용
- **CORS 설정**: `Access-Control-Allow-Origin: *` 무분별 사용
- **Rate Limiting**: 로그인, API 엔드포인트에 요청 제한 미설정
- **파일 업로드**: 확장자/크기/MIME 타입 검증 미흡

### MEDIUM

- **의존성 취약점**: `npm audit` 또는 `pip audit` 결과 확인
- **HTTP 헤더**: Helmet/보안 헤더 미적용 (X-Frame-Options, CSP 등)
- **세션 관리**: httpOnly, secure, sameSite 쿠키 설정 누락
- **로깅**: 민감 정보 마스킹 미처리, 로그 레벨 관리 미흡
- **에러 처리**: 상세 에러 메시지 클라이언트 노출

## 절차

1. 대상 파일을 읽고 위 항목을 점검한다
2. 발견된 취약점을 심각도별로 분류한다
3. 각 취약점에 대해 **현재 코드 → 수정 코드** 예시를 제공한다
4. 의존성 보안 점검 명령어를 실행한다 (`npm audit`, `pip audit` 등)

## 출력 형식

```
🔴 CRITICAL: [취약점 이름]
   파일: src/routes/users.ts:42
   현재: db.query(`SELECT * FROM users WHERE id = ${req.params.id}`)
   수정: db.query('SELECT * FROM users WHERE id = $1', [req.params.id])

🟡 HIGH: [취약점 이름]
   ...
```
