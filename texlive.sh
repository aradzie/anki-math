#!/usr/bin/env bash
# Runs a TeX Live / Asymptote command inside the project's custom podman
# image (see texlive-gl.Containerfile), which layers Xvfb on top of the
# upstream TeX Live image so Asymptote gets a real GLX display for
# hardware-style, depth-buffered 3D rendering, not just LaTeX compilation.
#
# One-time setup -- build the image locally:
#   podman build -t localhost/texlive-gl -f texlive-gl.Containerfile .
#
# Usage:
#   ./texlive.sh <command> [args...]
#
# Examples:
#   ./texlive.sh latexmk -pdf -halt-on-error main.tex
#   ./texlive.sh asy -f svg -render=0 -o out in.asy
#
# Image: $TEXLIVE_IMAGE (default: localhost/texlive-gl:latest).
#
# SOURCE_DATE_EPOCH (default: 0) is forwarded explicitly into the command's
# environment via `env` so pdfTeX embeds a fixed /CreationDate, /ModDate,
# and /ID instead of the wall-clock time. Built PDFs are committed alongside
# their sources, so a git- or clock-derived timestamp would make unrelated
# commits churn the embedded dates; pdfTeX reads this variable itself, no
# extra flags are needed. Rebuilding unchanged sources therefore produces
# byte-identical PDFs.
#
# --userns keep-id maps the container user to the host user so files written
# into the bind mount are owned by the invoking user, not root.
#
# The bind mount uses the lowercase :z SELinux label, not :Z. :Z applies a
# private label usable by only one container at a time; when a parallel
# build (make -j) launches several of these containers against the same
# directory at once, each tries to claim it exclusively and they race,
# producing spurious "Permission denied" errors. :z applies a shared label
# so concurrent containers can access the same bind mount safely.
#
# Xvfb is started directly rather than via xvfb-run: xvfb-run's SIGUSR1-based
# wait for Xvfb to report readiness hangs in this container environment
# (Xvfb comes up and creates its socket fine, but the signal round-trip
# that's supposed to unblock xvfb-run's `wait` never arrives). Polling for
# the socket file is what actually indicates it's ready to accept
# connections. This wrapping is harmless for non-GL commands (latexmk, plain
# 2D/wireframe asy calls), so it's applied unconditionally rather than only
# for raster PNG builds.

set -euo pipefail

image="${TEXLIVE_IMAGE:-localhost/texlive-gl:latest}"
source_date_epoch="${SOURCE_DATE_EPOCH:-0}"

if [ "$#" -eq 0 ]; then
    echo "usage: $(basename "$0") <command> [args...]" >&2
    exit 1
fi

exec podman run --rm -it --userns keep-id \
    -v "$PWD:/work:z" -w /work \
    "$image" env SOURCE_DATE_EPOCH="$source_date_epoch" \
    bash -c 'Xvfb :99 -screen 0 1280x1024x24 -nolisten tcp & until [ -e /tmp/.X11-unix/X99 ]; do sleep 0.1; done; export DISPLAY=:99; exec "$@"' bash "$@"
