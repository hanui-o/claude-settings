변경사항을 커밋하고 main 브랜치와 동기화한다.

## Instructions

1. **커밋:**
   - `git status`로 변경사항 확인
   - 변경이 있으면 Conventional Commits 형식으로 커밋
   - **한 줄로만 작성. 본문 없음. Co-Authored-By 없음.**

3. **main과 동기화:**
   - `git fetch origin main`
   - `git rebase origin/main`
   - 충돌 발생 시 사용자에게 알리고 대기
   - 성공 시 완료 확인

## Notes

- pre-commit hook 실패 시 문제를 수정하고 재시도
- rebase 중 충돌은 사용자의 판단이 필요하므로 자동으로 해결하지 않음
