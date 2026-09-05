## Purpose

This repository is a personal collection of self-study mathematics material, made up of three artifact types:

- **Flashcards** — `.note` source files imported into Anki for spaced repetition.
- **Self-check questions** — LaTeX source compiled into a single PDF of self-check questions, for testing understanding rather than passive review.
- **Essays** — LaTeX write-ups of deeper explorations of individual topics, kept for rereading.

This is not a conventional software project — do not assume the usual tooling (test suites, CI, linters) applies. The compilation and rendering steps that do exist (LaTeX, Asymptote) are documented explicitly below.

## Flashcards

Flashcards are plain-text `.note` files under `flashcards/`, organized by topic directory, imported into Anki via an external addon — there is no compile step. Full format rules, metadata directives, note-writing standards, and mathematical rigor requirements for flashcards are documented in `.agents/skills/generate-flashcards/SKILL.md`; follow that skill when creating, editing, or reviewing flashcards.

## Self-Check Questions

`self-check/self-check.tex` is the entrypoint for the self-check questions PDF: a single top-level LaTeX document that recursively `\input`s each topic's `.tex` files into one compiled PDF of readable, conceptually clear questions for active recall and conceptual reinforcement, not passive exposition. Topic files are content fragments, not standalone documents; only `self-check.tex` is compiled directly.

### Build Self-Check Questions

The `self-check/Makefile` builds the compiled self-check PDF, compiling the top-level document with `latexmk` via `texlive.sh` (see "TeX Live via `texlive.sh`" below).

## Essays

Essays are standalone `.tex` files in the `essays` directory, one per topic, each compiling to its own PDF. They are write-ups of deeper explorations of a topic — typically produced from a conversation with an LLM — kept around so rereading them later reinforces the ideas.

### Build Essays

A `Makefile` in the `essays` directory builds every essay to its own PDF. It compiles each `.tex` file with `latexmk` via `texlive.sh` (see "TeX Live via `texlive.sh`" below).

## TeX Live via `texlive.sh`

All compilation and rendering runs through `texlive.sh` at the repo root, a runner script each `Makefile` calls instead of invoking `podman` directly. It runs every command inside a custom image (`localhost/texlive-gl:latest`, overridable via `TEXLIVE_IMAGE`) built locally from `texlive-gl.Containerfile`. See `texlive.sh`'s own header comment for the rationale behind its GL/Xvfb setup, `SOURCE_DATE_EPOCH` handling, and `--userns keep-id`.

## Asymptote Illustrations

Illustrations are authored as Asymptote (`.asy`) source files under `flashcards/`, compiled via `flashcards/Makefile` through `texlive.sh` (see "TeX Live via `texlive.sh`" above) — to a vector `.svg` by default, or to a raster `.png` for 3D scenes with shaded surfaces that can't be vectorized. PNG output renders with a real transparent background (not an opaque one) via a two-render difference-matting step, which runs on the host through `uv run` rather than inside the TeX Live container, since the podman image has no Python/PIL/numpy and reconstruction can't happen inside the container. Full authoring, preview, and build workflow — including where sources live, the SVG/PNG decision, and the shared `common.asy` helpers — is documented in `.agents/skills/generate-illustrations/SKILL.md`; follow that skill when creating, editing, or compiling illustrations.

## Python Scripts

Any Python script written for this repo — build tooling, one-off analysis, anything — should be run via `uv run` (a `#!/usr/bin/env -S uv run --script` shebang with inline PEP 723 `dependencies`, or plain `uv run script.py`), not written to assume a particular pre-installed interpreter or package set. `uv` is assumed to already be installed on the host
