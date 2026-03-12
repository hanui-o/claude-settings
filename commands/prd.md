현재 브랜치의 변경사항을 분석하여 PR 설명을 생성한다.

## Instructions

1. **브랜치 변경사항 분석:**
   - `git branch --show-current`로 브랜치명 확인
   - `git log origin/main..HEAD --oneline`으로 커밋 목록 확인
   - `git diff origin/main...HEAD --stat`으로 변경 파일 확인
   - `git diff origin/main...HEAD`로 상세 변경 확인

2. **정보 추출:**
   - 변경된 파일/모듈 식별
   - 변경 유형 판단 (feature, bugfix, refactor, docs, test 등)
   - 브랜치명이나 커밋에서 이슈 키 추출

3. **PR 설명 생성:**

```markdown
## Summary
<!-- 변경 사항을 간단히 설명 -->

### Changes
- 변경 내용 목록

### Type of Change
- [ ] Feature
- [ ] Bugfix
- [ ] Refactor
- [ ] Documentation
- [ ] Test

### Related Issues
- #issue-number
```

4. 생성된 PR 설명을 사용자에게 표시
