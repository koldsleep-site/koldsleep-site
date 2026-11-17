#!/usr/bin/env bash
set -u
printf '=== AI Role Router 점검 (읽기 전용) ===\n'
for x in git claude gemini; do
  if command -v "$x" >/dev/null 2>&1; then
    printf '[설치됨] %-7s %s\n' "$x" "$(command -v "$x")"
  else
    printf '[없음] %-7s\n' "$x"
  fi
done
printf '\n설정 파일:\n'
for f in AGENTS.md CLAUDE.md GEMINI.md BRIEF.md TASKS.md HANDOFF.md DESIGN_SYSTEM.md PROJECT_CONTEXT.md; do
  [[ -f "$f" ]] && printf '[OK] %s\n' "$f" || printf '[없음] %s\n' "$f"
done
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf '\nGit 브랜치: %s\n' "$(git branch --show-current)"
  git status --short
else
  printf '\nGit 저장소 아님\n'
fi
printf '\n참고: 프로그램 설치만으로 로그인 또는 계정 한도가 검증되지는 않습니다.\n'
