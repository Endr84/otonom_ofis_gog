---
name: proje-takip
description: İnşaat projelerini takip eder. Bir mesajda "proje" kelimesi geçtiğinde (WhatsApp veya diğer kanallardan) otomatik tetiklenir. Ada numarası, parsel numarası ve müteahhit adı alarak Google Drive'da "{ada}-{parsel} Müteahhit" isimli klasör oluşturur, ruhsat takip şablonunu klasöre ekler, varsa hatırlatmaları Google Takvim'e kaydeder. gogcli (gog skill) ile çalışır.
metadata:
  openclaw:
    user-invocable: true
    disable-model-invocation: false
    requires:
      bins: [gogcli]
      env: [GOG_ACCOUNT]
---

# Proje Takip

Google servislerine gogcli üzerinden erişir — ayrı bir kimlik doğrulaması gerekmez.

## İş Akışı

1. **Bilgi topla** — mesajdan çıkar ya da eksik olanları kullanıcıya sor
2. **Drive klasörü oluştur** — `gogcli` ile
3. **Şablon ekle** — `RUHSAT_TEMPLATE_ID` tanımlıysa şablonu klasöre kopyala
4. **Takvim hatırlatması** — hatırlatma belirtildiyse ekle
5. **Onay mesajı** gönder

## Bilgi Toplama

Mesajdan çıkarılamayan bilgiler için sor:

- Ada numarası
- Parsel numarası
- Müteahhit adı
- Hatırlatma var mı? (tarih + kısa açıklama)

## gogcli Komutları

### Drive — Klasör Oluştur

```bash
gog drive mkdir "{ada}-{parsel} {Müteahhit}" --parent "$GDRIVE_PROJECTS_FOLDER_ID" --json
```

Komut bilinmiyorsa önce `gog drive --help` çalıştır.

### Drive — Şablon Kopyala (RUHSAT_TEMPLATE_ID doluysa)

```bash
gog docs copy "$RUHSAT_TEMPLATE_ID" \
  --name "Ruhsat Takip — {ada}-{parsel} {Müteahhit}" \
  --parent "<klasör_id>" \
  --json
```

### Takvim — Hatırlatma Ekle

```bash
gog calendar create \
  --title "{ada}-{parsel} {Müteahhit} — {açıklama}" \
  --date "YYYY-MM-DD" \
  --time "HH:MM" \
  --reminder "60m,1d" \
  --json
```

Komut bilinmiyorsa önce `gog calendar --help` çalıştır.

## Onay Mesajı

```
✅ Proje kaydedildi: {ada}-{parsel} {Müteahhit}
📁 Drive Klasörü: {folder_url}
📋 Ruhsat Takip: {template_url}     ← RUHSAT_TEMPLATE_ID tanımlıysa
📅 Hatırlatma: {tarih} — {başlık}   ← hatırlatma eklendiyse
```

## Ortam Değişkenleri

| Değişken | Zorunlu | Açıklama |
|---|---|---|
| `GOG_ACCOUNT` | Evet | Zaten gog skill'inde tanımlı |
| `GDRIVE_PROJECTS_FOLDER_ID` | Evet | Projelerin ekleneceği Drive klasörü ID |
| `RUHSAT_TEMPLATE_ID` | Hayır | Şablon Google Doc ID — **şablon hazır olunca ekle** |
