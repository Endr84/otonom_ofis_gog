# OpenClaw — Detaylı Araştırma Notları

> **Araştırma Tarihi:** 2026-02-24
> **Kaynak:** Web araştırması, resmi dokümantasyon, GitHub

---

## Nedir?

OpenClaw (eski adları: Clawdbot → Moltbot → OpenClaw), Peter Steinberger tarafından Kasım 2025'te geliştirilen açık kaynak, otonom bir AI agent sistemidir. Ocak 2026'da viral oldu, 200.000+ GitHub yıldızı kazandı.

**Temel fark:** ChatGPT gibi sadece soru-cevap yapmaz. Shell komutları çalıştırır, tarayıcıyı kontrol eder, dosyaları okur/yazar, takvim ve e-posta yönetir — tümünü bir mesajla tetikleyerek.

---

## Önemli Gelişmeler (Şubat 2026)

- **14 Şubat 2026:** Yaratıcı Peter Steinberger OpenAI'ye katıldı.
- Proje bir açık kaynak vakfına devredildi — OpenAI fon sağlıyor ama proje açık kaynak kalmaya devam ediyor.
- Bu geçiş projenin uzun vadeli sürdürülebilirliğini garanti altına aldı.

---

## Temel Özellikler

### Yapabilecekleri
- Shell komutları çalıştırma
- Tarayıcı otomasyonu
- Dosya okuma/yazma
- Takvim yönetimi
- E-posta gönderme/okuma
- Kod yazma ve çalıştırma
- Çok adımlı iş akışları (neredeyse sıfır insan müdahalesi)

### Kanal Desteği
WhatsApp, Telegram, Slack, Discord, Google Chat, Signal, Microsoft Teams, Matrix, iMessage, iOS/Android WebChat ve daha fazlası.

---

## Multi-Agent Mimari (Bizim İçin Kritik)

### Nasıl Çalışır?
OpenClaw, tek bir Gateway içinde birden fazla izole agent çalıştırabilir:
- Her agent'ın ayrı `workspace`, `agentDir` ve `session`'ı var
- Gelen trafik (kanal/hesap/peer) bir agent'a "binding" ile yönlendirilir
- Örnek: 2 farklı WhatsApp hesabı → 2 farklı agent

### Otonom Ofis İçin Önemi
- Kullanıcı başına izole agent = çok kullanıcılı sistem mümkün
- Her kullanıcı kendi yetenekleriyle özelleştirilmiş bir agent alır
- Tek bir Gateway üzerinden tüm sistemi yönetmek mümkün

---

## Donanım/Altyapı Gereksinimleri

| Senaryo | Minimum |
|---------|---------|
| Temel sohbet | 2GB RAM, 2 CPU çekirdeği |
| Tarayıcı otomasyonu | 4GB RAM |
| Üretim (çok kullanıcılı) | VPS ($5/ay) veya DigitalOcean App Platform |

### Dağıtım Seçenekleri
- Docker ile küçük VPS (Hetzner, DigitalOcean)
- AWS (Pulumi ile)
- DigitalOcean App Platform (önerilen: her zaman açık, multi-agent)

---

## Mission Control (Ekip/Kurumsal Kullanım)

[Mission Control](https://github.com/abhi1693/openclaw-mission-control) — OpenClaw'u ekip/kurumsal ölçekte yönetmek için:
- Merkezi görünürlük (tüm agent'lar tek arayüzde)
- Onay mekanizmaları (kritik işlemler için insan onayı)
- API destekli otomasyon
- Gateway-farkında orkestrasyon

---

## Güvenlik Notları

- Yüzlerce güvensiz (açıkta kalmış) OpenClaw örneği tespit edildi
- Kötü amaçlı eklentiler mevcut (özellikle kripto hedefli)
- **Üretim kurulumunda:** Güvenlik duvarı, auth katmanı zorunlu

---

## Önemli Linkler

| Kaynak | URL |
|--------|-----|
| GitHub | [github.com/openclaw/openclaw](https://github.com/openclaw/openclaw) |
| Resmi Site | [openclaw.ai](https://openclaw.ai) |
| Dokümantasyon | [docs.openclaw.ai](https://docs.openclaw.ai) |
| Multi-Agent Docs | [docs.openclaw.ai/concepts/multi-agent](https://docs.openclaw.ai/concepts/multi-agent) |
| Mission Control | [github.com/abhi1693/openclaw-mission-control](https://github.com/abhi1693/openclaw-mission-control) |

---

## Sonraki Araştırma Konuları

- [ ] OpenClaw kurulum adımları (Docker ile)
- [ ] Multi-agent routing detaylı konfigürasyonu
- [ ] LLM seçimi (maliyet/performans analizi)
- [ ] Kanal entegrasyonu (hangi kanalları kullanacağız?)
- [ ] Güvenlik mimarisi
