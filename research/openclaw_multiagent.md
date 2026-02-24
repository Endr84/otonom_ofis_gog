# OpenClaw Multi-Agent Kurulum — Araştırma Notları

> **Araştırma Tarihi:** 2026-02-24
> **Kaynak:** docs.openclaw.ai/concepts/multi-agent

---

## Temel Konsept

Her agent tamamen izole bir varlıktır:
- Ayrı `workspace` (SOUL.md, AGENTS.md, USER.md)
- Ayrı `agentDir` (kimlik doğrulama + oturum)
- Ayrı WhatsApp hesabı (bot numarası)

---

## WhatsApp Multi-Agent Mimarisi

**Her agent için ayrı bir bot WhatsApp numarası gerekir.**

```
Çalışan → kendi telefonundan → BOT numarası A → Agent A (admin workspace)
Sekreter → kendi telefonundan → BOT numarası B → Agent B (sekreter workspace)
```

Yani: kaç agent varsa o kadar bot numarası/SIM gereklidir.

---

## Kurulum Adımları

### 1. Agent Oluştur

```bash
openclaw agents add <agent-id>
```

Örnek (otonom ofis):
```bash
openclaw agents add reakto          # admin agent
openclaw agents add sekreter        # sekreter agent
```

Her komut şunları oluşturur:
- `~/.openclaw/workspace-<id>/` — kişilik dosyaları
- `~/.openclaw/agents/<id>/` — session + auth

### 2. WhatsApp Hesaplarını Bağla

```bash
openclaw channels login --channel whatsapp --account reakto
openclaw channels login --channel whatsapp --account sekreter
```

Her komut QR kodu ile ilgili bot numarasını eşleştirir.

### 3. openclaw.json Yapısı

```json5
{
  agents: {
    list: [
      {
        id: "reakto",
        default: true,
        workspace: "~/.openclaw/workspace-reakto"
      },
      {
        id: "sekreter",
        workspace: "~/.openclaw/workspace-sekreter",
        tools: {
          deny: ["write", "edit", "exec"]   // kısıtlı yetkiler
        }
      }
    ]
  },

  bindings: [
    {
      agentId: "reakto",
      match: { channel: "whatsapp", accountId: "reakto" }
    },
    {
      agentId: "sekreter",
      match: { channel: "whatsapp", accountId: "sekreter" }
    }
  ],

  channels: {
    whatsapp: {
      accounts: {
        reakto: {},
        sekreter: {}
      }
    }
  }
}
```

### 4. Kişilik Tanımla (SOUL.md)

Her workspace'e ayrı kişilik:

`~/.openclaw/workspace-reakto/SOUL.md`:
```markdown
# Reakto — Ofis Yönetici Asistanı
Proaktif, kısa ve net yanıtlar ver. Türkçe konuş.
```

`~/.openclaw/workspace-sekreter/SOUL.md`:
```markdown
# Sekreter Asistanı
Profesyonel, detaylı, yapılandırılmış yanıtlar ver. Türkçe konuş.
```

### 5. Restart + Doğrulama

```bash
openclaw gateway restart
openclaw agents list --bindings
openclaw channels status --probe
```

Beklenen çıktı:
```
reakto   → whatsapp / reakto
sekreter → whatsapp / sekreter
```

---

## Shared Skills Davranışı

`~/.openclaw/skills/` altındaki skill'ler **tüm agent'lar** tarafından paylaşılır.

Öncelik sırası (her agent için):
```
1. <agent-workspace>/skills/     ← agent'a özel override
2. ~/.openclaw/skills/           ← paylaşımlı (proje-takip buraya kurulu)
3. Bundled skills
```

`proje-takip` skill'i her iki agent tarafından da tetiklenebilir — Drive ve takvim yetkileri aynı GOG_ACCOUNT üzerinden çalışır.

---

## Hata Ayıklama

```bash
openclaw gateway logs                    # genel loglar
openclaw agents list --bindings          # binding kontrolü
openclaw channels status --probe         # WhatsApp bağlantı durumu
```

---

## Önemli Notlar

| Konu | Detay |
|------|-------|
| Bot numarası | Her agent için ayrı SIM/numara gerekli |
| agentDir paylaşımı | ASLA iki agent aynı agentDir'i kullanmamalı |
| Skill paylaşımı | `~/.openclaw/skills/` tüm agentlara görünür |
| openclaw.json | Sadece admin düzenler (OS izni ile korunuyor) |
| agents.defaults | `agents.list` yapısına geçince defaults içindeki model/compaction ayarları her agent'a ayrı tanımlanmalı VEYA OpenClaw bunları miras alıyor mu test edilmeli |
