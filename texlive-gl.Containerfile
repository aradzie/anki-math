# Layers Xvfb on top of the upstream TeX Live image so its bundled
# Asymptote -- which already supports GL rendering and already has Mesa's
# software GL stack installed, just no X server to hand it a context -- gets
# a real GLX display for hardware-style, depth-buffered 3D rendering.
#
# Build (one-time):
#   podman build -t localhost/texlive-gl -f texlive-gl.Containerfile .
FROM registry.gitlab.com/islandoftex/images/texlive:latest
RUN apt-get update && apt-get install -y --no-install-recommends xvfb \
    && rm -rf /var/lib/apt/lists/*
