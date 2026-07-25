## Purpose

This repository contains LaTeX source files for mathematical self-check question sets.

The documents are for active recall and conceptual reinforcement, not passive exposition.

Primary output:

- standalone `.tex` files, compilable with `pdflatex`
- readable, conceptually clear question sets

This is not a conventional software project — do not assume the usual tooling (test suites, CI, linters) applies. The compilation and rendering steps that do exist (LaTeX, Asymptote, PyVista) are documented explicitly below.

## Content Standards

Prefer questions that test understanding rather than recall. Good prompts usually ask the learner to explain, derive, compare, interpret, check assumptions, or analyze failure cases.

Useful patterns include:

- why does ...
- under what conditions ...
- what breaks if ...
- how are X and Y related ...
- give an interpretation of ...
- derive ...
- compare ...
- construct a counterexample ...

Default to a small number of substantial questions per topic. Group them by conceptual theme, with depth increasing as each section progresses.

Avoid by default:

- trivial definition regurgitation
- shallow repetition of the same question
- purely computational drill unless computation is the point
- vague prompts with no clear mathematical target

Keep the material technically precise and direct. Do not add filler or motivational language. Simplify when useful, but do not sacrifice correctness.

## Mathematical Rigor

All mathematical statements must be:

- internally consistent
- notation-consistent
- logically correct
- explicit about assumptions

Do not conflate intuition with proof or use false equivalences for pedagogical convenience.

When compressing rigor for pedagogical reasons, preserve correctness and explicitly state what is being omitted, approximated, or treated informally.

## LaTeX Style

Use:

- `align*` for multi-line derivations
- semantic sectioning such as `\section` and `\subsection`
- consistent inline math formatting
- standard mathematical notation

## TeX Live via Podman

No local TeX/Asymptote/Ghostscript install is assumed or required. All compilation and rendering runs inside the `texlive` docker image via `podman`, so the only host dependency is `podman` itself (able to pull `registry.gitlab.com/islandoftex/images/texlive:latest`). An example invocation of the texlive image is given below:

```sh
podman run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$DIR:/work:Z" -w /work "$IMAGE" \
  latexmk -pdf ...
```

- `--userns keep-id` maps the container user to the host user so files written into the bind mount (`-v "$DIR:/work:Z"`) are owned by the invoking user, not root.
- `-w /work` runs the command from the mounted directory.
- `SOURCE_DATE_EPOCH=0` is exported before the run and passed through with `-e` so pdfTeX embeds a fixed `/CreationDate`, `/ModDate`, and `/ID` instead of the wall-clock time. Built PDFs are committed alongside their sources, so a git- or clock-derived timestamp would make unrelated commits churn the embedded dates; pdfTeX reads this variable itself, no extra flags are needed. Rebuilding unchanged sources therefore produces byte-identical PDFs.
- `$DIR`/`$IMAGE` above are illustrative; the actual values are defined in make files and build scripts.

## Asymptote Illustrations (2D only)

Vector illustrations are authored as Asymptote (`.asy`) source files.

Run `make` in `illustrations/` to (re)generate the `.pdf` and `.svg` files for every `.asy` file (see `illustrations/Makefile`); it runs, per file:

```sh
podman run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$DIR:/work:Z" -w /work "$IMAGE" \
  asy -f pdf -render=0 "$name.asy"
podman run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$DIR:/work:Z" -w /work "$IMAGE" \
  asy -f svg -render=0 "$name.asy"
```

- `asy -f pdf -render=0` compiles the `.asy` source to a vector PDF, which is what gets embedded via `\includegraphics` in the LaTeX documents.
- `asy -f svg -render=0` compiles the same source to a vector SVG preview, using `dvisvgm` (bundled in the texlive image) to typeset LaTeX labels as real vector glyphs rather than rasterizing them.
- `common.asy` is only tracked as a prerequisite in the Makefile (so editing it rebuilds every illustration) — it holds shared helpers imported by the other files, not a standalone illustration.
- Make's incremental rebuilds mean an unchanged `.asy` file is left alone; only sources newer than their `.pdf`/`.svg` (or a changed `common.asy`) are re-rendered.

Commit the generated `.pdf` and `.svg` files alongside the `.asy` source; rebuilding unchanged sources produces byte-identical output.

## PyVista Illustrations (3D only)

3D illustrations are Python scripts using PyVista/VTK, run through the repo's `uv` project (`pyproject.toml`/`uv.lock` at the repo root). Unlike Asymptote's vector backend, PyVista does real z-buffered rendering, so scenes with multiple occluding or transparent objects don't need manual draw-order bookkeeping. The tradeoff is raster-only output (PNG, no vector PDF) and axis labels that are plain text rather than LaTeX-typeset math.

Run `make` in `illustrations/` to (re)generate the `.png` files for every `.py` file (same `illustrations/Makefile`); it runs, per file:

```sh
uv run --project "$ROOT" "$name.py"
```

- `--project "$ROOT"` points `uv run` at the repo-root `pyproject.toml`/`uv.lock` explicitly, so the PyVista/VTK environment resolves correctly regardless of the caller's current directory.
- `common.py` is tracked as a prerequisite in the Makefile, so editing the shared helpers rebuilds every illustration.

Commit the generated `.png` alongside the `.py` source.
