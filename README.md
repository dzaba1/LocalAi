# LocalAi
A self-hosted AI environment based on Ollama, Open WebUI, SearXNG and ComfyUI.

## Getting started

Start the stack with:

```powershell
.\up.ps1
```

This wraps `docker-compose up` (any extra arguments, e.g. `-d`, are forwarded to it). On first run it generates a `.env` file at the repo root containing a random `SEARXNG_SECRET`. Do not delete `.env` unless you want a new secret generated (this will invalidate existing SearXNG sessions).

## ComfyUI integration

ComfyUI is not part of the compose stack. Run it on the host; Open WebUI reaches it at `http://host.docker.internal:8188` (configured in `docker-compose.yml`).

1. Start ComfyUI so that it is reachable from the container (it listens on `127.0.0.1` by default), and allow port 8188 through the firewall if needed:

   ```
   python main.py --listen 0.0.0.0 --port 8188
   ```

2. In ComfyUI, enable **Dev mode options** in Settings, build a working text-to-image workflow and export it with **Save (API Format)**.
3. In Open WebUI go to **Admin Panel → Settings → Images**. Image generation is already enabled with the ComfyUI engine and base URL via environment variables; use the verify button next to the URL to check the connection.
4. Upload the exported workflow JSON under **ComfyUI Workflow** and map the node IDs (at minimum **Prompt**; optionally **Model**, **Width/Height**, **Steps**, **Seed**). Save.
5. In a chat, use the image icon under a response to generate an image from it.

The workflow and node mapping are stored in Open WebUI's data directory (`data/open-webui`). Values saved in the UI take precedence over the environment variables once Open WebUI has started.
