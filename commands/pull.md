원격 저장소의 최신 변경사항을 가져와 현재 브랜치에 반영한다.

## Instructions

1. **현재 상태 확인:**
   - `git branch --show-current`로 현재 브랜치 확인
   - `git status --short`로 uncommitted 변경사항 확인
   - uncommitted 변경이 있으면 사용자에게 알리고 stash 여부 확인

2. **Pull 실행:**
   - `git pull --rebase origin <현재 브랜치>`
   - rebase 충돌 발생 시 사용자에게 알리고 대기

3. **결과 확인:**
   - `git log --oneline -5`로 최신 커밋 확인
   - 사용자에게 완료 보고

## Notes

- rebase 전략을 기본으로 사용 (merge commit 방지)
- 충돌은 사용자의 판단이 필요하므로 자동으로 해결하지 않음
