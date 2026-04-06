# Wyoming OpenAI Edge TTS

This app combines two services inside one Home Assistant app container:

- `openai-edge-tts` provides a local OpenAI-compatible text-to-speech API.
- `wyoming-openai` exposes that TTS backend over the Wyoming protocol for Home Assistant.

## What this app exposes

- Wyoming endpoint: port `10300`
- Optional raw OpenAI-compatible TTS API: port `5050`

After the app starts, Home Assistant should be able to discover it automatically through the Wyoming integration. You can also point the Wyoming integration manually at the host running this app on port `10300`.

## Installation

1. Add this repository to Home Assistant as a custom app repository.
2. Install `Wyoming OpenAI Edge TTS` from the store.
3. Adjust the voices or languages if needed.
4. Start the app.
5. In Home Assistant, add or reload the Wyoming integration.

## Discovery behavior

This app publishes Wyoming discovery information automatically after startup.

In most setups, Home Assistant will show a discovered Wyoming integration that already has the URI. You typically only need to confirm the discovered integration.

If discovery does not appear, reload the Wyoming integration page, then add Wyoming manually with this app host and port `10300`.

## Configuration

### Voices

`tts_voices` is a text field. Enter a space-separated list of voices to advertise through Wyoming.

Available voices can be browsed here: https://tts.travisvn.com/

Example:

```txt
en-US-EmmaNeural en-US-ChristopherNeural
```

### Languages

`wyoming_languages` is a text field. Enter a space-separated list of language codes that Wyoming should advertise.

Example:

```txt
en
```

### Default language

`default_language` is passed to `openai-edge-tts` and controls which locale is used when voice lists are filtered.

Example:

```txt
en-US
```

## Notes

- The defaults use US English with Emma and Christopher voices.
- `require_api_key` stays disabled by default because Wyoming talks to the internal Edge TTS endpoint without an API key.
- Port `5050` is disabled by default on the host. Enable it only if you also want direct access to the OpenAI-compatible API.
- This app pins `openai-edge-tts` to commit `edaed2afd2cdedcc4648380185d8d7cf7a1eee97` and `wyoming-openai` to `0.4.3` for predictable builds.

## Support

If the app is not discovered after startup, reload the Wyoming integration or add it manually using the host and port `10300`.

## Credits

This app builds on two upstream projects:

- `openai-edge-tts` by Travis van Nimwegen: https://github.com/travisvn/openai-edge-tts
- `wyoming-openai` by Rory Eckel: https://github.com/roryeckel/wyoming_openai

