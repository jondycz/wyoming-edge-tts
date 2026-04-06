# Wyoming Edge TTS

This repository contains a Home Assistant app for exposing Microsoft Edge TTS voices through Wyoming.

## Credits

This repository packages work from these upstream projects:

- `openai-edge-tts` by Travis van Nimwegen: https://github.com/travisvn/openai-edge-tts
- `wyoming-openai` by Rory Eckel: https://github.com/roryeckel/wyoming_openai

## Included app

- `Wyoming Edge TTS`

## Adding this repository to Home Assistant

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