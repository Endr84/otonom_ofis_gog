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
| 2026-02-24 | **Skill stratejisi: `~/.openclaw/skills/`** | Tüm agent'ların paylaştığı konuma kurulum → bir kez kur, herkes kullanır |
| 2026-02-24 | **Google auth: gog skill OAuth (service account YOK)** | gogcli zaten OAuth kurulu ve çalışıyor; service account gereksiz karmaşıklık |
| 2026-02-24 | **İlk skill: `proje-takip`** | WhatsApp'ta "proje" tetikleyiciyle Drive klasörü + ruhsat şablonu + takvim hatırlatması |

---

## Teknoloji Yığını

| Katman | Teknoloji | Durum |
|--------|-----------|-------|
| AI Agent Altyapısı | [OpenClaw](https://github.com/openclaw/openclaw) | Kurulu — test aşaması |
| Google Entegrasyonu | [gogcli](https://github.com/steipete/gogcli) + `gog` skill | **Çalışıyor** — OAuth doğrulandı |
| Skill: Proje Takip | `skills/proje-takip/` | **Kuruldu — uzun vadeli test** |
| LLM | OpenRouter (openrouter/auto) | Kurulu |
| Mesajlaşma Kanalları | WhatsApp (birincil) | Kurulu — test aşaması |
| Dağıtım | Local (`/home/reakto-asistan`) | Çalışıyor |
| Orkestrasyon | OpenClaw Mission Control (opsiyonel) | Bekliyor |

---

## Öğrenilen Dersler / Hatalar ve Çözümleri

### Hata Kaydı

Proje boyunca karşılaşılan hatalar ve kalıcı çözümleri burada saklanır — aynı hata bir daha yaşanmasın.

| Tarih | Hata | Çözüm | Kaynak |
|-------|------|-------|--------|
| 2026-02-24 | Skill için service account + Python scripts tasarlandı | gogcli zaten OAuth kuruluyla aynı işi yapıyor; Python kaldırıldı, gogcli bash script'lerine geçildi | proje-takip skill geliştirme |

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
