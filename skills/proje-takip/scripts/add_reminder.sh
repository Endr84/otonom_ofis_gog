#!/usr/bin/env bash
# Proje için Google Takvim hatırlatması ekler.
#
# Kullanım:
#   ./add_reminder.sh --title "..." --date "YYYY-MM-DD" [--time "HH:MM"] [--description "..."]
#
# Ortam değişkenleri:
#   GOG_ACCOUNT — gogcli hesabı (gog skill'inden devralınır)

set -euo pipefail

TITLE=""
DATE=""
TIME=""
DESCRIPTION=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title)       TITLE="$2";       shift 2 ;;
    --date)        DATE="$2";        shift 2 ;;
    --time)        TIME="$2";        shift 2 ;;
    --description) DESCRIPTION="$2"; shift 2 ;;
    *) echo "Bilinmeyen parametre: $1" >&2; exit 1 ;;
  esac
done

if [[ -z "$TITLE" || -z "$DATE" ]]; then
  echo "Hata: --title ve --date zorunludur." >&2
  exit 1
fi

gog calendar create \
  --title "$TITLE" \
  --date "$DATE" \
  ${TIME:+--time "$TIME"} \
  ${DESCRIPTION:+--description "$DESCRIPTION"} \
  --reminder "60m,1d" \
  --json
