# LocalAi
A self-hosted AI environment based on Ollama, Open WebUI, SearXNG and ComfyUI.

## Getting started

Start the stack with:

```powershell
.\up.ps1
```

This wraps `docker-compose up` (any extra arguments, e.g. `-d`, are forwarded to it). On first run it generates a `.env` file at the repo root containing a random `SEARXNG_SECRET`. Do not delete `.env` unless you want a new secret generated (this will invalidate existing SearXNG sessions).
