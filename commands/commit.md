변경사항을 확인하고 커밋한다.

## Instructions

1. **변경사항 리뷰:**
   - `git status --short`로 변경 파일 확인
   - `git diff`로 변경 내용 확인
   - `git log --oneline -5`로 최근 커밋 스타일 확인

3. **커밋 메시지 생성:**
   - Conventional Commits 형식: `feat:`, `fix:`, `refactor:`, `style:`, `chore:` 등
   - **한 줄로만 작성. 본문 없음. Co-Authored-By 없음.**

4. **커밋 실행:**
   - `git add` (파일명 지정 선호, `.env` 등 민감 파일 제외)
   - `git commit -m "$(cat <<'EOF'
[commit message]
EOF
)"` 실행

5. pre-commit hook 실패 시 문제를 수정하고 재시도
