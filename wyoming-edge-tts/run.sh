#!/usr/bin/with-contenv bashio

set -euo pipefail

cleanup() {
    if [[ -n "${WYOMING_PID:-}" ]] && kill -0 "${WYOMING_PID}" 2>/dev/null; then
        kill "${WYOMING_PID}"
        wait "${WYOMING_PID}" || true
    fi

    if [[ -n "${EDGE_TTS_PID:-}" ]] && kill -0 "${EDGE_TTS_PID}" 2>/dev/null; then
        kill "${EDGE_TTS_PID}"
        wait "${EDGE_TTS_PID}" || true
    fi
}

trap cleanup EXIT SIGINT SIGTERM

export PORT=5050
export DEFAULT_LANGUAGE="$(bashio::config 'default_language')"
export DEFAULT_SPEED="$(bashio::config 'default_speed')"
export REQUIRE_API_KEY="$(bashio::config 'require_api_key')"
export REMOVE_FILTER="$(bashio::config 'remove_filter')"
export EXPAND_API="$(bashio::config 'expand_api')"

export TTS_BACKEND=OPENAI
export TTS_MODELS="$(bashio::config 'tts_models')"
export TTS_OPENAI_URL=http://127.0.0.1:5050/v1
export TTS_SPEED="$(bashio::config 'default_speed')"
export TTS_STREAMING_MODELS="$(bashio::config 'tts_streaming_models')"
export TTS_VOICES="$(bashio::config 'tts_voices')"
export WYOMING_LANGUAGES="$(bashio::config 'wyoming_languages')"
export WYOMING_LOG_LEVEL="$(bashio::config 'wyoming_log_level')"
export WYOMING_URI=tcp://0.0.0.0:10300

bashio::log.info "Starting OpenAI Edge TTS on port ${PORT}"
python /opt/openai-edge-tts/app/server.py &
EDGE_TTS_PID=$!

bashio::log.info "Waiting for OpenAI Edge TTS to become ready"
python3 - <<'PY'
import sys
import time
import urllib.request

for _ in range(40):
    try:
        with urllib.request.urlopen("http://127.0.0.1:5050/v1/models", timeout=5):
            sys.exit(0)
    except Exception:
        time.sleep(1)

sys.exit(1)
PY

bashio::log.info "Starting Wyoming OpenAI on ${WYOMING_URI}"
python -m wyoming_openai &
WYOMING_PID=$!

bashio::net.wait_for 10300

config=$(bashio::var.json \
    uri "tcp://$(hostname):10300" \
)

if bashio::discovery "wyoming" "${config}" > /dev/null; then
    bashio::log.info "Published Wyoming discovery information"
else
    bashio::log.warning "Failed to publish Wyoming discovery information"
fi

wait "${WYOMING_PID}"
