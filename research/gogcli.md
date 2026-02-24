# gogcli — Araştırma Notları

> **Araştırma Tarihi:** 2026-02-24
> **Kaynak:** [github.com/steipete/gogcli](https://github.com/steipete/gogcli)
> **OpenClaw Skill:** [clawhub.ai/steipete/gog](https://clawhub.ai/steipete/gog) — v1.0.0

---

## Nedir?

`gogcli` — "Google in your terminal." Google Workspace servislerine terminal üzerinden erişim sağlayan CLI aracı. OpenClaw'da `gog` skill olarak kullanılıyor.

---

## Desteklenen Google Servisleri

| Servis | Komut | Notlar |
|--------|-------|--------|
| Gmail | `gog gmail ...` | Arama, gönderme, etiket yönetimi |
| Calendar | `gog calendar ...` | Etkinlik oluşturma/listeleme |
| Drive | `gog drive ...` | Dosya işlemleri |
| Contacts | `gog contacts ...` | Kişi yönetimi |
| Tasks | `gog tasks ...` | Görev listesi |
| Sheets | `gog sheets ...` | Spreadsheet işlemleri |
| Docs | `gog docs ...` | Doküman işlemleri |
| Slides | `gog slides ...` | Sunum işlemleri |
| Forms | `gog forms ...` | Form işlemleri |
| Chat | `gog chat ...` | Google Chat |
| Keep | `gog keep ...` | **Sadece Workspace hesaplarında çalışır!** |
| Classroom | `gog classroom ...` | Google Classroom |

---

## Kurulum

```bash
# macOS
brew install steipete/tap/gogcli

# Arch Linux
yay -S gogcli

# Kaynaktan (Go gerekli)
git clone <repo> && make
```

---

## İlk Kurulum — OAuth2 Adımları

```bash
# 1. Google Cloud Console'dan OAuth2 credentials al → JSON olarak indir
gog auth credentials <dosya.json>

# 2. Hesap ekle
gog auth add your@email.com

# 3. Test
gog gmail labels list
```

---

## Önemli Kullanım Notları

### Hesap Seçimi
```bash
# Ortam değişkeni ile
GOG_ACCOUNT=hesap@gmail.com gog gmail search "konu"

# Flag ile
gog gmail search "konu" --account hesap@gmail.com
```

### Çıktı Formatı
```bash
gog gmail search "konu" --json    # JSON çıktı (script/agent için ideal)
gog gmail search "konu" --plain   # Düz metin
# Varsayılan: insan dostu tablo
```

### Servis Kapsamı Kısıtlama
```bash
gog auth add hesap@gmail.com --services drive,calendar --readonly
```

---

## Bilinen Kısıtlamalar / Dikkat Edilecekler

| Sorun | Detay |
|-------|-------|
| Keep API | Sadece Google Workspace hesaplarında çalışır, kişisel Gmail'de ÇALIŞMAZ |
| Service Account | Domain-wide delegation ayarı gerektirir |
| Token Storage | OS keyring veya şifreli disk — ortama göre farklı davranabilir |
| Go runtime | Kaynaktan derleme için Go gerekli |

---

## OpenClaw Entegrasyonu (gog skill)

Skill kurulu: `clawhub.ai/steipete/gog` — v1.0.0

OpenClaw'da `gog` skill olarak çalışır. Agent Google servislerine doğal dil ile erişebilir:
- "Gmail'deki faturaları bul" → `gog gmail search "fatura"`
- "Yarın saat 10'a toplantı ekle" → `gog calendar create ...`

### Skill Konfigürasyonu (`~/.openclaw/openclaw.json`)
```json5
{
  skills: {
    entries: {
      "gog": {
        enabled: true,
        env: {
          GOG_ACCOUNT: "hesap@gmail.com"
        }
      }
    }
  }
}
```

---

## Sorun Giderme Notları

> Bu bölüm test sürecinde karşılaşılan hatalar eklendikçe güncellenecek.

| Tarih | Hata | Çözüm |
|-------|------|-------|
| — | — | — |
