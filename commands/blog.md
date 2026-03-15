블로그 글을 작성하거나 velog에서 이전한다.

## Instructions

### 1. 노션 발행 계획 확인

- 노션 "Claude Code 블로그 시리즈 계획" 페이지에서 오늘 작성할 글 확인
- 신규 글인지, velog 이전 글인지 파악

### 2. 신규 글 작성

1. **기존 글 톤 확인**: `apps/docs/src/content/blog/` 기존 글 1개를 읽어 톤과 구조 파악
2. **mdx 파일 생성**: `apps/docs/src/content/blog/[slug].mdx`
3. **frontmatter 필수 항목**:
   ```yaml
   ---
   title: '제목'
   description: 'SEO용 설명 (1~2줄)'
   date: 'YYYY-MM-DD'
   tags: ['태그1', '태그2']
   author: 'odada'
   ---
   ```
4. **글 하단에 항상 포함**:
   - [claude-settings](https://github.com/hanui-o/claude-settings) 링크
   - 관련 프로젝트 링크
   - 시리즈 이전/다음 편 링크
5. **톤**: 친근한 경험 공유 ("~해봤어요", "~이에요")

### 3. velog 이전 글 작성

velog에서 hanui 블로그로 이전할 때는 **반드시 두 파일을 함께 생성**한다:

1. **hanui 블로그용 mdx** — `apps/docs/src/content/blog/[slug].mdx`
   - `docs/blog/velog/` 원본 파일의 내용을 mdx로 변환
   - frontmatter 추가 (date는 velog 원본 날짜 유지)
   - 이미지 경로, 링크 등을 hanui 블로그 형식으로 변환

2. **velog 이전 공지용 md** — `docs/blog/velog/[번호]-[slug]-notice.md`
   - 형식:
   ```markdown
   # [원본 제목]

   > 이 글의 원본은 **<a href="https://hanui.io/blog/[slug]" target="_blank" rel="noopener noreferrer">hanui 블로그</a>로 이전**했어요.
   > 더 나은 가독성과 최신 내용은 원본 링크에서 확인해주세요!
   >
   > 👉 https://hanui.io/blog/[slug]

   ---

   [원본 글 첫 두세 문단 요약]

   전체 내용은 hanui 블로그에서 확인하세요 → **https://hanui.io/blog/[slug]**
   ```

**velog 이전 공지 파일을 빠뜨리면 안 된다.**

### 4. 빌드 확인

- `pnpm build`로 빌드 통과 확인
- 에러 시 수정 후 재시도

### 5. 커밋

- `/commit` 커맨드로 커밋
- 커밋 메시지 예시: `docs(blog): CLAUDE.md 작성법 3편 추가`
