# BRAIN — Ana Bilgi Tabanı

> **Son Güncelleme:** 2026-02-24
> Bu dosya projenin "beyni"dir. Kararlar, öğrenilen dersler, mimari seçimler ve kritik bilgiler burada tutulur.

---

## Projenin Amacı

**Otonom Ofis Asistanı** — OpenClaw altyapısı üzerine kurulu, çok kullanıcılı bir ofis otomasyon sistemi.

- Ofis süreçlerini otomatikleştirmek (e-posta, takvim, dosya yönetimi, raporlama)
- Birden fazla kullanıcının aynı sistemde izole agent'larla çalışabilmesi
- Farklı mesajlaşma kanalları üzerinden (Slack, WhatsApp, Telegram vb.) erişim
- Kullanıcı başına özelleştirilebilir agent yetenekleri

---

## Mimari Kararlar

| Tarih | Karar | Gerekçe |
|-------|-------|---------|
| 2026-02-24 | Proje oluşturuldu | Başlangıç kurulumu |
| 2026-02-24 | **Altyapı: OpenClaw** | Açık kaynak, multi-agent routing desteği, her platforma kurulum imkanı |
| 2026-02-24 | **Çok kullanıcılı mimari** | OpenClaw'un izole agent/workspace sistemi bu yapıyı destekliyor |

---

## Teknoloji Yığını

| Katman | Teknoloji | Durum |
|--------|-----------|-------|
| AI Agent Altyapısı | [OpenClaw](https://github.com/openclaw/openclaw) | Araştırılıyor |
| LLM | Belirlenmedi (OpenClaw ile uyumlu herhangi biri) | Bekliyor |
| Mesajlaşma Kanalları | Slack / Telegram / WhatsApp (OpenClaw entegrasyonu) | Bekliyor |
| Dağıtım | VPS / Docker / DigitalOcean App Platform | Bekliyor |
| Orkestrasyon | OpenClaw Mission Control (opsiyonel) | Bekliyor |

---

## Öğrenilen Dersler / Hatalar ve Çözümleri

### Hata Kaydı

Proje boyunca karşılaşılan hatalar ve kalıcı çözümleri burada saklanır — aynı hata bir daha yaşanmasın.

| Tarih | Hata | Çözüm | Kaynak |
|-------|------|-------|--------|
| — | — | — | — |

---

## Kritik Notlar

- Yeni bir karar alındığında bu dosyaya eklenir.
- Bir hata çözüldüğünde hata kaydına girilir.
- Mimari değişiklikler tarih damgasıyla kaydedilir.

---

## Bağlantılı Dosyalar

- [Araştırma Günlüğü](../research/research_log.md)
- [Görev Listesi](../todo/todo.md)
- [Kurulum Rehberi](../docs/setup_guide.md)
