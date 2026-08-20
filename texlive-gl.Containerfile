# Layers Xvfb on top of the upstream TeX Live image so its bundled
# Asymptote -- which already supports GL rendering and already has Mesa's
# software GL stack installed, just no X server to hand it a context -- gets
# a real GLX display for hardware-style, depth-buffered 3D rendering.
#
# Build (one-time):
#   podman build -t localhost/texlive-gl -f texlive-gl.Containerfile .
#
# Pinned to a dated weekly snapshot rather than :latest: the upstream image
# tracks CTAN continuously, so :latest can silently pick up new package
# versions (fonts, hyphenation patterns, math packages, ...) between builds.
# That changes rendered glyphs even with SOURCE_DATE_EPOCH fixed, which
# defeats reproducibility of the PDFs committed alongside their sources.
# Bump this tag deliberately (and recompile + review the resulting diffs)
# when you want newer packages; see the available tags at
# https://gitlab.com/islandoftex/images/texlive/container_registry.
FROM registry.gitlab.com/islandoftex/images/texlive:TL2026-2026-08-16-full
RUN apt-get update && apt-get install -y --no-install-recommends xvfb \
    && rm -rf /var/lib/apt/lists/*
