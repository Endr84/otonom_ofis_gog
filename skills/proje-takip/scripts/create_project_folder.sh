#!/usr/bin/env bash
# Proje için Google Drive klasörü oluşturur ve (varsa) şablon kopyalar.
#
# Kullanım:
#   ./create_project_folder.sh --ada 123 --parsel 45 --muteahhit "Ahmet Yapı"
#
# Ortam değişkenleri:
#   GDRIVE_PROJECTS_FOLDER_ID  — projelerin ekleneceği üst klasör ID (zorunlu)
#   RUHSAT_TEMPLATE_ID         — şablon Google Doc ID (opsiyonel)
#   GOG_ACCOUNT                — gogcli hesabı (gog skill'inden devralınır)

set -euo pipefail

ADA=""
PARSEL=""
MUTEAHHIT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ada)      ADA="$2";      shift 2 ;;
    --parsel)   PARSEL="$2";   shift 2 ;;
    --muteahhit) MUTEAHHIT="$2"; shift 2 ;;
    *) echo "Bilinmeyen parametre: $1" >&2; exit 1 ;;
  esac
done

if [[ -z "$ADA" || -z "$PARSEL" || -z "$MUTEAHHIT" ]]; then
  echo "Hata: --ada, --parsel ve --muteahhit zorunludur." >&2
  exit 1
fi

FOLDER_NAME="${ADA}-${PARSEL} ${MUTEAHHIT}"

# 1. Klasör oluştur
echo "Klasör oluşturuluyor: $FOLDER_NAME" >&2
FOLDER_JSON=$(gog drive mkdir "$FOLDER_NAME" \
  ${GDRIVE_PROJECTS_FOLDER_ID:+--parent "$GDRIVE_PROJECTS_FOLDER_ID"} \
  --json)

FOLDER_ID=$(echo "$FOLDER_JSON" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")
FOLDER_URL=$(echo "$FOLDER_JSON" | python3 -c "import sys,json; print(json.load(sys.stdin).get('webViewLink',''))")

RESULT="{\"folder_id\":\"$FOLDER_ID\",\"folder_name\":\"$FOLDER_NAME\",\"folder_url\":\"$FOLDER_URL\"}"

# 2. Şablon kopyala (varsa)
TEMPLATE_ID="${RUHSAT_TEMPLATE_ID:-}"
if [[ -n "$TEMPLATE_ID" ]]; then
  echo "Şablon kopyalanıyor..." >&2
  TMPL_JSON=$(gog docs copy "$TEMPLATE_ID" \
    --name "Ruhsat Takip — $FOLDER_NAME" \
    --parent "$FOLDER_ID" \
    --json)
  TMPL_URL=$(echo "$TMPL_JSON" | python3 -c "import sys,json; print(json.load(sys.stdin).get('webViewLink',''))")
  RESULT=$(echo "$RESULT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
d['template_url'] = '$TMPL_URL'
print(json.dumps(d, ensure_ascii=False))
")
fi

echo "$RESULT"
