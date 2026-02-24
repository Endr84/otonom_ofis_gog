# OpenClaw Hafıza & Kimlik Sistemi — Araştırma Notları

> **Araştırma Tarihi:** 2026-02-24
> **Kaynak:** docs.openclaw.ai + topluluk kaynakları

---

## Sorun: Agent Her Oturumda "Ben Kimim?" Diye Soruyor

**Kök Neden:** `BOOTSTRAP.md` tamamlanıp silinmemiş. Agent dosyayı her oturumda görünce yeniden onboarding başlatıyor.

**Çözüm:** Kimlik dosyalarını (IDENTITY.md, USER.md, SOUL.md) doldur → BOOTSTRAP.md'yi sil.

---

## Workspace Dosya Yapısı

```
~/.openclaw/workspace/
├── BOOTSTRAP.md     ← TEK SEFERLİK — tamamlanınca SİLİNMELİ
├── AGENTS.md        ← Operasyon kuralları, iş akışı, güvenlik
├── SOUL.md          ← Agent'ın iç kişiliği ve davranış felsefesi
├── IDENTITY.md      ← Agent'ın dışa yansıyan kimliği (isim, emoji, vibe)
├── USER.md          ← Kullanıcı profili — her oturumda yüklenir
├── TOOLS.md         ← Araç kullanım notları
├── HEARTBEAT.md     ← Proaktif davranış tetikleyicileri
└── memory/
    ├── YYYY-MM-DD.md  ← Günlük loglar (append-only)
    └── MEMORY.md      ← Uzun vadeli özet (curated)
```

---

## Kimlik Dosyaları

### IDENTITY.md — Dışa Yansıyan Kimlik
```markdown
# Identity

name: Reakto
nature: Ofis asistanı AI agent
vibe: Doğrudan, yardımsever, verimlilik odaklı
emoji: 🦞
```
> **Boyut hedefi:** < 1KB

---

### USER.md — Kullanıcı Profili (Her Oturumda Yüklenir)
```markdown
# User Profile

name: [Kullanıcı adı]
timezone: Europe/Istanbul
language: Türkçe (birincil), English (ikincil)
context: Otonom Ofis projesini geliştiriyor. OpenClaw altyapısı, Google Workspace entegrasyonu.
preferences:
  - Kısa ve net yanıtlar
  - Teknik detayları dahil et
  - Gereksiz soru sorma
```
> **Boyut hedefi:** < 2KB

---

### SOUL.md — İç Kişilik ve Davranış Felsefesi
```markdown
# Soul

## Core Truths
- Gerçekten yardımcı ol, sadece yanıt ver değil
- Teknik konularda araştır, tahmin etme
- Hatırla: önceki konuşmalar USER.md ve memory/ içinde

## Boundaries
- Özel bilgileri koru
- Dışa iletişimde onay iste

## Vibe
- Kurumsal dil kullanma
- Gerektiğinde doğrudan ol
- Türkçe konuş
```
> **Boyut hedefi:** < 3KB

---

## BOOTSTRAP.md Sorunu — Neden Tekrar Çalışıyor?

| Durum | Açıklama |
|-------|---------|
| BOOTSTRAP.md hala var | Tamamlanmadı veya silinmedi → her oturumda tetikliyor |
| IDENTITY.md boş/eksik | Agent kimlik bulamıyor → bootstrap'e dönüyor |
| USER.md boş/eksik | Kullanıcıyı tanımıyor → tekrar soruyor |

**Çözüm adımları:**
1. IDENTITY.md, USER.md, SOUL.md dosyalarını doldur
2. BOOTSTRAP.md'yi **sil**
3. Yeni oturum aç → agent artık sormayacak

---

## Hafıza Sistemi

### Kısa Vadeli (Oturum İçi)
- Tüm yukarıdaki dosyalar oturum başında sistem promptuna enjekte edilir
- Toplam boyut limiti: **~15-20KB**

### Uzun Vadeli
- `memory/YYYY-MM-DD.md` — günlük append-only loglar
- `memory/MEMORY.md` — agent'ın önemli kararları buraya özet alır

### Memory Search (Gelişmiş)
```json
{
  "memorySearch": {
    "enabled": true,
    "provider": "gemini",
    "model": "gemini-embedding-001"
  }
}
```
> **Dikkat:** Embedding provider ayarlanmazsa `memory_search` sessizce başarısız olur!

---

## Önemli Notlar

- `BOOTSTRAP.md` → **tek seferlik, tamamlanınca sil**
- `USER.md` → her oturumda otomatik yüklenir, burası dolu olmalı
- `IDENTITY.md` → agent adı ve kimliği, dolu olmalı
- Dosya değişiklikleri bir sonraki yeni oturumda aktif olur

---

## Kaynaklar

- [docs.openclaw.ai/start/bootstrapping](https://docs.openclaw.ai/start/bootstrapping)
- [docs.openclaw.ai/concepts/memory](https://docs.openclaw.ai/concepts/memory)
- [docs.openclaw.ai/reference/templates/IDENTITY](https://docs.openclaw.ai/reference/templates/IDENTITY)
- [docs.openclaw.ai/reference/templates/SOUL](https://docs.openclaw.ai/reference/templates/SOUL)
