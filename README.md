# Wyoming Edge TTS

This repository contains a Home Assistant app for exposing Microsoft Edge TTS voices through Wyoming.

## Streaming Support for Edge TTS

Microsoft Edge TTS is excellent for voice quality, but Home Assistant voice pipelines work best with Wyoming-native streaming behavior.

This add-on bridges that gap by combining OpenAI Edge TTS with Wyoming OpenAI, so Home Assistant gets responsive, streaming-capable TTS from Edge voices with lower perceived latency during playback.

Note: As of today, the Home Assistant mobile app does not support streaming streaming TTS audio, so this app is primarily aimed at the Home Assistant Voice Preview Edition and other ESP based voice satellites.

## Credits

This repository packages work from these upstream projects:

- `openai-edge-tts` by Travis van Nimwegen: https://github.com/travisvn/openai-edge-tts
- `wyoming-openai` by Rory Eckel: https://github.com/roryeckel/wyoming_openai

## Included app

- `Wyoming Edge TTS`

## Adding this repository to Home Assistant

[![Show add-on](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=72119c17_wyoming-edge-tts&repository_url=https%3A%2F%2Fgithub.com%2Fjondycz%2Fwyoming-edge-tts)

1. Open Home Assistant.
2. Go to **Settings** > **Apps**.
3. Open the app store.
4. Add this repository as a custom repository.
5. Install `Wyoming Edge TTS`.

See `wyoming-edge-tts/DOCS.md` for configuration details.

## Container publishing

Images are published to GHCR using GitHub Actions:

- Image: `ghcr.io/jondycz/wyoming-edge-tts`
- Workflow: `.github/workflows/publish-ghcr.yml`

On push to `main`, the workflow builds and publishes multi-arch images for `linux/amd64` and `linux/arm64`.
