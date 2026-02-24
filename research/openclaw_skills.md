# OpenClaw Skill Sistemi — Araştırma Notları

> **Araştırma Tarihi:** 2026-02-24
> **Kaynak:** [docs.openclaw.ai/tools/skills](https://docs.openclaw.ai/tools/skills)

---

## Skill Nedir?

OpenClaw skill'leri, agent'a yeni araçlar/yetenekler ekleyen modüler yapılardır. Her skill bir `SKILL.md` dosyasından oluşur (YAML metadata + talimatlar).

---

## Skill Yükleme Önceliği

```
1. <workspace>/skills/          ← en yüksek öncelik (proje bazlı)
2. ~/.openclaw/skills/          ← kullanıcı bazlı
3. Bundled (dahili) skills      ← en düşük öncelik
```

Aynı isimde skill varsa workspace versiyonu kazanır.

---

## SKILL.md Formatı

```markdown
---
name: skill-adi
description: Ne yaptığını açıkla
metadata:
  openclaw:
    user-invocable: true          # /skill-adi komutu olarak kullanılabilir mi?
    disable-model-invocation: false  # Agent otomatik çağırabilir mi?
    command-dispatch: tool        # Doğrudan araç çağırma modu
    requires:
      bins: [gogcli]              # PATH'te olması gereken araçlar
      env: [GOG_ACCOUNT]         # Zorunlu ortam değişkenleri
      os: [darwin, linux, win32] # Desteklenen işletim sistemleri
---

Skill talimatları burada...
```

---

## Gating — Koşullu Yükleme

Skill sadece gereksinimler karşılandığında yüklenir:

| Gereksinim | Açıklama | Örnek |
|-----------|---------|-------|
| `bins` | PATH'te bulunması gereken program | `[gogcli, ffmpeg]` |
| `env` | Zorunlu ortam değişkeni | `[OPENAI_API_KEY]` |
| `config` | openclaw.json'da olması gereken ayar | `{feature: true}` |
| `os` | İşletim sistemi kısıtlaması | `[darwin, linux]` |

---

## Konfigürasyon (`~/.openclaw/openclaw.json`)

```json5
{
  skills: {
    entries: {
      "skill-adi": {
        enabled: true,          // skill aktif mi?
        env: {
          API_KEY: "değer"      // skill'e özel env değişkenleri
        },
        config: {
          customSetting: true   // skill'e özel ayarlar
        }
      }
    }
  }
}
```

---

## ClawHub — Skill Pazarı

[clawhub.ai](https://clawhub.ai) üzerinden skill keşfet ve yükle:

```bash
clawhub install steipete/gog      # Skill kur
clawhub update --all              # Tüm skillleri güncelle
clawhub sync --all                # Tüm skillleri senkronize et
```

---

## Önemli Davranış Notları

- **Oturum başlangıcında snapshot:** Skill değişiklikleri anında değil, bir sonraki yeni oturumda etkinleşir.
- **Workspace önceliği:** Projeye özel skill aynı isimli global skill'i ezer.
- **Disabled skill:** `enabled: false` yapılırsa agent skill'i görmez.

---

## Kurulu Skill Listesi (Bu Proje)

| Skill | Kaynak | Durum |
|-------|--------|-------|
| `gog` | [clawhub.ai/steipete/gog](https://clawhub.ai/steipete/gog) | Kurulu — test aşaması |
