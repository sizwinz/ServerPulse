# 🧠 ServerPulse  
### Real-Time AI Discord Analytics Bot

![Python](https://img.shields.io/badge/Python-3.11+-blue?logo=python)
![Discord.py](https://img.shields.io/badge/discord.py-v2.4+-5865F2?logo=discord)
![License](https://img.shields.io/badge/License-MIT-green)
![Docker](https://img.shields.io/badge/Docker-Supported-blue?logo=docker)

> **ServerPulse** brings advanced analytics, live alerts, and AI-generated insights directly to your Discord server.

---

## 🌍 Overview

- ServerPulse continuously tracks your Discord server’s activity like messages, joins, reactions, and more, and turns that data into actionable insights.  
- It’s powered by a multi-provider AI layer (Gemini, OpenAI, Grok, OpenRouter) that writes daily and weekly “Pulse Reports” right inside your Discord channel.

**Use it for:**  
- 📈 Server growth tracking 
- 🧩 Engagement analysis 
- 💬 Community sentiment 
- 🎯 Activity alerts

---

## ✨ Features

### ⚡ Real-Time Monitoring
- Tracks messages, joins/leaves, reactions, and voice activity
- Detects spikes, drops, or raids instantly  
- Sends alerts automatically to a configured `#serverpulse-updates` channel

### 🏆 Leaderboards & Engagement Stats
- `/topmessagers [24h|7d|30d|all]` — show most active users  
- `/leaderboard #channel` — per-channel rankings  
- Cached via Redis for speed  

### 🧠 AI-Generated Insights
- Weekly “Pulse Reports” with:
  - Top users & busiest channels  
  - Community sentiment breakdown  
  - AI-suggested engagement improvements  
- Supports **Gemini**, **OpenAI**, **OpenRouter**, and **Grok**  
- Each guild can bring its own AI key  

### 🔔 Instant Alerts
| Alert | Trigger | Example |
|-------|----------|---------|
| **Join Raid** | 10+ joins in 60 s | “⚠️ 12 members joined in under a minute!” |
| **Activity Drop** | >50 % drop vs avg | “📉 Activity decreased 52 % since yesterday.” |
| **Mass Deletion** | 5+ deletes in 30 s | “🧹 7 messages deleted rapidly.” |
| **Voice Surge** | 3× more VC users | “🎙️ Voice channels suddenly active!” |

### 🔒 Privacy-First Design
- No raw messages or attachments stored  
- Only aggregated counts & IDs saved  
- Channel tracking is opt-in (`/add-collect-channel`)  
- Default retention: 90 days (configurable)  

---

## 🐳 One-Command Docker Deployment

### 📦 Quick Start

```bash
git clone https://github.com/sizwinz/ServerPulse.git
cd ServerPulse
cp .env.example .env
# Edit your BOT_TOKEN and (optionally) AI keys
docker compose up --build -d
````

That’s it. ServerPulse, MongoDB, and Redis will start together automatically.

---

## ⚙️ Environment Variables

| Variable             | Description                                                    |
| -------------------- | -------------------------------------------------------------- |
| `BOT_TOKEN`          | Discord bot token                                              |
| `MONGODB_URI`        | MongoDB connection string                                      |
| `REDIS_URL`          | Redis connection string                                        |
| `AI_PROVIDER`        | Default AI provider (`openrouter`, `gemini`, `openai`, `grok`) |
| `OPENAI_API_KEY`     | Optional OpenAI key                                            |
| `GEMINI_API_KEY`     | Optional Gemini key                                            |
| `GROK_API_KEY`       | Optional Grok key                                              |
| `OPENROUTER_API_KEY` | Optional OpenRouter key                                        |

See `.env.example` for template.

---

## 🧩 Commands

| Command                            | Description                  |
| ---------------------------------- | ---------------------------- |
| `/setup`                           | Interactive setup wizard     |
| `/set-update-channel #channel`     | Choose where updates post    |
| `/add-collect-channel #channel`    | Start tracking a channel     |
| `/remove-collect-channel #channel` | Stop tracking                |
| `/topmessagers [period]`           | Display activity leaderboard |
| `/leaderboard #channel`            | Channel-specific stats       |
| `/toggle-alert <type>`             | Enable/disable alert         |
| `/set-digest <freq>`               | Configure digest schedule    |
| `/pulse-now`                       | Generate report instantly    |
| `/export-report`                   | Export analytics (CSV/JSON)  |

---

## 🧠 Architecture

```
┌──────────────────────────┐
│ discord.py Event Stream  │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│  Metrics Collector       │
│  (messages, joins, etc.) │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ MongoDB + Redis Cache    │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ AI Adapter Layer         │
│ (Gemini / OpenAI / ...)  │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ Discord Update Channel   │
│ (reports + alerts)       │
└──────────────────────────┘
```

---

## 🧰 Developer Commands

| Action      | Command                                   |
| ----------- | ----------------------------------------- |
| Start stack | `docker compose up -d`                    |
| Stop stack  | `docker compose down`                     |
| View logs   | `docker compose logs -f serverpulse`      |
| Rebuild     | `docker compose build --no-cache`         |
| Wipe DB     | `docker volume rm serverpulse_mongo_data` |

---

## 🛠️ Tech Stack

* **Language:** Python 3.11+
* **Framework:** discord.py v2
* **Database:** MongoDB 6 + Redis
* **Scheduler:** discord.ext.tasks.loop
* **AI Layer:** Gemini / OpenAI / OpenRouter / Grok
* **Containerization:** Docker + Compose

---

## 🧭 Roadmap

| Version  | Highlights                                        |
| -------- | ------------------------------------------------- |
| **v1.0** | Real-time analytics, AI summaries, Docker release |
| **v1.1** | Voice analytics, custom thresholds                |
| **v2.0** | `/askpulse` chatbot, predictive goals             |

---

## 🤝 Contributing

Pull requests welcome!
Focus areas:

* New AI integrations (Claude, Cohere)
* Smarter anomaly detection
* Localization / translations
* Enhanced metrics visualization

See **CONTRIBUTING.md** for details.

---

## 📜 License

MIT License © 2025 [Sahaj Italiya](https://github.com/sizwinz)

---

## 💬 Support

* Issues → [GitHub Issues](https://github.com/sizwinz/ServerPulse/issues)
