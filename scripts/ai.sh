#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
mode="${1:-help}"
if [[ "$#" -gt 0 ]]; then shift; fi
case "$mode" in
  status)
    echo '=== 현 작업 ==='
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git status --short
      printf 'Branch: %s\n' "$(git branch --show-current)"
    else echo 'Git 저장소가 아닙니다.'; fi
    printf '\nTASKS.md\n'
    [[ -f TASKS.md ]] && sed -n '1,35p' TASKS.md || echo 'TASKS.md 없음'
    ;;
  gemini)
    command -v gemini >/dev/null 2>&1 || { echo 'Gemini CLI 미설치: npm install -g @google/gemini-cli' >&2; exit 127; }
    exec gemini "$@"
    ;;
  claude)
    command -v claude >/dev/null 2>&1 || { echo 'Claude Code 미설치' >&2; exit 127; }
    exec claude --model sonnet "$@"
    ;;
  opus)
    command -v claude >/dev/null 2>&1 || { echo 'Claude Code 미설치' >&2; exit 127; }
    exec claude --model opus "$@"
    ;;
  help|-h|--help)
    printf '사용법: bash scripts/ai.sh {status|gemini|claude|opus}\n'
    ;;
  *)
    printf '지원하지 않는 명령: %s\n' "$mode" >&2; exit 2;;
esac
