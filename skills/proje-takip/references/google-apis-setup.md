# Kurulum Notları

## Kimlik Doğrulama

Bu skill **gog skill'inin OAuth kurulumunu devralır** — ayrıca service account veya ek OAuth kurulumu gerekmez. `GOG_ACCOUNT` zaten gog skill'inde tanımlı.

## Sadece Gereken Ortam Değişkenleri

`~/.openclaw/openclaw.json` dosyasına ekle:

```json
{
  "skills": {
    "proje-takip": {
      "env": {
        "GDRIVE_PROJECTS_FOLDER_ID": "17Kknp593Q5Zq8gKlz6ALqdZyc8WAP1it",
        "RUHSAT_TEMPLATE_ID": "13v6ccHZbVdR4d76vS65jzNIWwssldb-MjkSEfhLd9v4"
      }
    }
  }
}
```

## openclaw.json Yedeği Alma

Değişiklik yapmadan önce:

```bash
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.bak
```

## Komut Sözdizimi Doğrulama

gogcli sürümüne göre komut adları farklılık gösterebilir. Emin olmak için:

```bash
gog drive --help
gog calendar --help
gog docs --help
```
