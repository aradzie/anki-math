#!/usr/bin/env bash
# Runs a TeX Live / Asymptote command through one of several interchangeable
# backends, so Makefiles in this repo don't hardcode a single podman
# invocation. Selected via TEXLIVE_BACKEND (default: podman).
#
# Usage:
#   ./texlive.sh <command> [args...]
#
# Examples:
#   ./texlive.sh latexmk -pdf -halt-on-error main.tex
#   ./texlive.sh asy -f svg -render=0 -o out in.asy
#   TEXLIVE_BACKEND=toolbox ./texlive.sh latexmk -pdf main.tex
#   TEXLIVE_BACKEND=system  ./texlive.sh latexmk -pdf main.tex
#
# Backends (TEXLIVE_BACKEND):
#   podman   (default) Run inside the texlive podman image, bind-mounting
#            $PWD at /work. Image: $TEXLIVE_IMAGE (default below).
#   toolbox  Run inside a toolbox container via `toolbox run`. Toolbox
#            containers share the host filesystem and cwd, so no bind mount
#            is needed. Uses the default toolbox container unless
#            TEXLIVE_TOOLBOX names one explicitly.
#   system   Run the command directly from $PATH, assuming a host TeX
#            Live / Asymptote install.
#
# In every backend, SOURCE_DATE_EPOCH (default: 0) is forwarded explicitly
# into the command's environment via `env`, rather than relying on
# backend-specific environment-passing flags, so pdfTeX's embedded
# timestamps stay reproducible regardless of backend.

set -euo pipefail

backend="${TEXLIVE_BACKEND:-podman}"
image="${TEXLIVE_IMAGE:-registry.gitlab.com/islandoftex/images/texlive:latest}"
source_date_epoch="${SOURCE_DATE_EPOCH:-0}"

if [ "$#" -eq 0 ]; then
    echo "usage: $(basename "$0") <command> [args...]" >&2
    exit 1
fi

case "$backend" in
    system)
        exec env SOURCE_DATE_EPOCH="$source_date_epoch" "$@"
        ;;
    podman)
        exec podman run --rm -it --userns keep-id \
            -v "$PWD:/work:Z" -w /work \
            "$image" env SOURCE_DATE_EPOCH="$source_date_epoch" "$@"
        ;;
    toolbox)
        toolbox_args=()
        if [ -n "${TEXLIVE_TOOLBOX:-}" ]; then
            toolbox_args+=(--container="$TEXLIVE_TOOLBOX")
        fi
        exec toolbox run "${toolbox_args[@]}" \
            env SOURCE_DATE_EPOCH="$source_date_epoch" "$@"
        ;;
    *)
        echo "$(basename "$0"): unknown TEXLIVE_BACKEND '$backend' (expected: system, podman, toolbox)" >&2
        exit 1
        ;;
esac
