#!/usr/bin/env bash
# Render a `// output: png` Asymptote scene to a PNG with a real transparent
# background, via the two-render difference-matting technique: render the
# scene once with its background forced to black, once to white, then
# reconstruct true alpha/RGB from the pair (reconstruct-transparent-png.py).
# See the "SVG vs. PNG output" section of
# .claude/skills/generate-illustrations/SKILL.md for the full rationale.
#
# Usage: render-transparent-png.sh <asy-render-level> <src.asy> <dest.png>
#
# Must be invoked with flashcards/ as the working directory, as
# flashcards/Makefile does -- both <src.asy> and <dest.png> are paths
# relative to flashcards/, matching how asy itself is invoked elsewhere in
# this build so `import common;`/`import common3d;` resolve.

set -euo pipefail

if [ "$#" -ne 3 ]; then
    echo "usage: $(basename "$0") <asy-render-level> <src.asy> <dest.png>" >&2
    exit 1
fi

render_level=$1
src=$2
dest=$3

script_dir=$(cd "$(dirname "$0")" && pwd)
texlive_sh="$script_dir/../texlive.sh"
reconstruct_py="$script_dir/reconstruct-transparent-png.py"

anchor='mathdefaults();'
if ! grep -qxF "$anchor" "$src"; then
    {
        echo "render-transparent-png.sh: $src has no bare '$anchor' line."
        echo "This script injects 'currentlight.background = ...;' immediately"
        echo "after that line to force a solid render background for each of the"
        echo "two renders it difference-mattes; without that exact anchor line"
        echo "there is no safe injection point. See the 'SVG vs. PNG output'"
        echo "section of .claude/skills/generate-illustrations/SKILL.md."
    } >&2
    exit 1
fi

src_dir=$(dirname "$src")
src_base=$(basename "$src" .asy)
dest_dir=$(dirname "$dest")
dest_base=$(basename "$dest" .png)

# Note: temp filenames deliberately are NOT dot-hidden -- Asymptote's LaTeX
# label rendering builds its own intermediate filenames from the -o prefix,
# and a prefix whose basename starts with "." breaks that path construction
# (confirmed empirically: pdftex fails with a mangled -output-directory
# argument). Instead, ".transient." marks these as build-generated so
# flashcards/Makefile's ASY_SOURCES glob can exclude them by that marker
# (`-not -name '*.transient.*'`) without depending on the exact random
# suffix mktemp picks.
black_asy=$(mktemp -p "$src_dir" "${src_base}.transient.XXXXXX-black.asy")
white_asy=$(mktemp -p "$src_dir" "${src_base}.transient.XXXXXX-white.asy")
black_png="${black_asy%.asy}.png"
white_png="${white_asy%.asy}.png"
out_tmp=$(mktemp -p "$dest_dir" "${dest_base}.transient.XXXXXX-out.png")

cleanup() {
    rm -f "$black_asy" "$white_asy" "$black_png" "$white_png" "$out_tmp"
}
trap cleanup EXIT

sed "s/^${anchor}\$/${anchor}\\ncurrentlight.background = black;/" "$src" > "$black_asy"
sed "s/^${anchor}\$/${anchor}\\ncurrentlight.background = white;/" "$src" > "$white_asy"

# -render=$render_level: Asymptote's own default (2) does hardware,
# depth-buffered GL rendering, needed for correct occlusion of overlapping
# translucent surfaces; this requires a live display, which texlive.sh's
# podman image provides via a bundled Xvfb -- see flashcards/Makefile's
# ASY_RENDER comment.
"$texlive_sh" asy -f png -render="$render_level" -o "${black_asy%.asy}" "$black_asy"
"$texlive_sh" asy -f png -render="$render_level" -o "${white_asy%.asy}" "$white_asy"

"$reconstruct_py" "$black_png" "$white_png" "$out_tmp"

mv "$out_tmp" "$dest"
