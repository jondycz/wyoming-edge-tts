ARG BUILD_FROM=ghcr.io/home-assistant/base:latest
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Pinned commit on main branch after v2.0.0 that includes ffmpeg conversion fixes.
ARG OPENAI_EDGE_TTS_VERSION=edaed2afd2cdedcc4648380185d8d7cf7a1eee97
ARG WYOMING_OPENAI_VERSION=0.4.3

RUN apk add --no-cache \
     curl \
    ffmpeg \
    py3-pip \
     tar \
    python3 \
 && python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --no-cache-dir --upgrade pip \
 && mkdir -p /tmp/openai-edge-tts \
 && curl -L "https://api.github.com/repos/travisvn/openai-edge-tts/tarball/${OPENAI_EDGE_TTS_VERSION}" \
     | tar -xz --strip-components=1 -C /tmp/openai-edge-tts \
 && mv /tmp/openai-edge-tts /opt/openai-edge-tts \
 && /opt/venv/bin/pip install --no-cache-dir -r /opt/openai-edge-tts/requirements.txt \
 && /opt/venv/bin/pip install --no-cache-dir "wyoming-openai==${WYOMING_OPENAI_VERSION}"

ENV PATH=/opt/venv/bin:$PATH

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
