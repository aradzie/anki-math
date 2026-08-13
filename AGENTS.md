## Purpose

This repository is a personal collection of self-study mathematics material, made up of three artifact types:

- **Flashcards** — `.note` source files imported into Anki for spaced repetition.
- **Self-check questions** — LaTeX source compiled into a single PDF of self-check questions, for testing understanding rather than passive review.
- **Essays** — LaTeX write-ups of deeper explorations of individual topics, kept for rereading.

This is not a conventional software project — do not assume the usual tooling (test suites, CI, linters) applies. The compilation and rendering steps that do exist (LaTeX, Asymptote) are documented explicitly below.

## Content Standards

These standards apply whenever generating or reviewing content on a mathematical topic, across all three artifact types — flashcards, self-check questions, and essays alike.

Prefer content that tests or builds understanding rather than recall. Good prompts usually ask the learner to explain, derive, compare, interpret, check assumptions, or analyze failure cases.

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

## Flashcards

Flashcards are plain-text `.note` files under `flashcards/`, organized by topic directory, imported into Anki via an external addon — there is no compile step. They follow the Content Standards above. Full format rules, metadata directives, note-writing standards, and mathematical rigor requirements for flashcards are documented in `.agents/skills/generate-flashcards/SKILL.md`, which specializes the Content Standards above for card granularity and phrasing; follow that skill when creating, editing, or reviewing flashcards.

## Self-Check Questions

`self-check/self-check.tex` is the entrypoint for the self-check questions PDF: a single top-level LaTeX document that recursively `\input`s each topic's `.tex` files into one compiled PDF of readable, conceptually clear questions for active recall and conceptual reinforcement, not passive exposition. Topic files are content fragments, not standalone documents; only `self-check.tex` is compiled directly. They follow the Content Standards above.

### Build Self-Check Questions

The `self-check/Makefile` builds the compiled self-check PDF. It first runs `node self-check-stats.js`, which walks the topic files included from the top-level document and regenerates `self-check-stats.tex` — this step needs a host `node` install, unlike the LaTeX steps below, since it runs directly rather than inside the TeX Live container. It then compiles the top-level document with `latexmk` via `texlive.sh` (see "TeX Live via `texlive.sh`" below), producing the PDF. Commit the regenerated `self-check-stats.tex` alongside content changes that add or remove questions.

## Essays

Essays are standalone `.tex` files in the `essays` directory, one per topic, each compiling to its own PDF. They are write-ups of deeper explorations of a topic — typically produced from a conversation — kept around so rereading them later reinforces the ideas.

### Build Essays

A `Makefile` in the `essays` directory builds every essay to its own PDF. It compiles each `.tex` file with `latexmk` via `texlive.sh` (see "TeX Live via `texlive.sh`" below).

## TeX Live via `texlive.sh`

All compilation and rendering runs through `texlive.sh` at the repo root, a runner script each `Makefile` calls instead of invoking `podman` directly. It runs every command inside a custom image (`localhost/texlive-gl:latest`, overridable via `TEXLIVE_IMAGE`) built locally from `texlive-gl.Containerfile`.

The custom image layers `xvfb` on top of the upstream `registry.gitlab.com/islandoftex/images/texlive:latest` image. The bundled Asymptote already supports GL rendering and the image already has Mesa's software GL stack installed — the stock image was just missing an X server to hand it a context. `texlive.sh` starts a virtual `Xvfb` display inside the container before running the given command, so Asymptote gets a real GLX display for correct hardware-style, depth-buffered rendering (needed for raster PNG illustrations — see "Asymptote Illustrations" below) as well as plain LaTeX/SVG builds, which don't need a display but are unaffected by having one.

`SOURCE_DATE_EPOCH` (default: `0`) is forwarded explicitly into the command's environment via `env`, so pdfTeX embeds a fixed `/CreationDate`, `/ModDate`, and `/ID` instead of the wall-clock time. Built PDFs are committed alongside their sources, so a git- or clock-derived timestamp would make unrelated commits churn the embedded dates; pdfTeX reads this variable itself, no extra flags are needed. Rebuilding unchanged sources therefore produces byte-identical PDFs. `--userns keep-id` maps the container user to the host user so files written into the bind mount are owned by the invoking user, not root.

## Asymptote Illustrations

Illustrations are authored as Asymptote (`.asy`) source files under `flashcards/`, compiled via `flashcards/Makefile` through `texlive.sh` (see "TeX Live via `texlive.sh`" above) — to a vector `.svg` by default, or to a raster `.png` for 3D scenes with shaded surfaces that can't be vectorized. PNG output renders with a real transparent background (not an opaque one) via a two-render difference-matting step, which runs on the host through `uv run` rather than inside the TeX Live container, since the podman image has no Python/PIL/numpy and reconstruction can't happen inside the container. Full authoring, preview, and build workflow — including where sources live, the SVG/PNG decision, and the shared `common.asy` helpers — is documented in `.agents/skills/generate-illustrations/SKILL.md`; follow that skill when creating, editing, or compiling illustrations.

## Python Scripts

Any Python script written for this repo — build tooling, one-off analysis, anything — should be run via `uv run` (a `#!/usr/bin/env -S uv run --script` shebang with inline PEP 723 `dependencies`, or plain `uv run script.py`), not written to assume a particular pre-installed interpreter or package set. `uv` is assumed to already be installed on the host
