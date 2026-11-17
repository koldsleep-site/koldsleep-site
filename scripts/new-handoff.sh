#!/usr/bin/env bash
set -euo pipefail
file='HANDOFF.md'
if [[ ! -f "$file" ]]; then
  echo "HANDOFF.md가 없습니다. 프로젝트 루트에서 실행하세요." >&2
  exit 1
fi
cat >> "$file" <<EOF

### $(date '+%Y-%m-%d %H:%M') — [작업명]
- 담당 AI:
- 변경 파일:
- 실행·검증:
- 미해결 위험:
- 다음 한 단계:
EOF
printf '인수인계 항목을 추가했습니다: %s\n' "$file"
