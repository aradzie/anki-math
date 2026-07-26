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

Flashcards are plain-text `.note` files organized by topic directory, imported into Anki via an external addon — there is no compile step. They follow the Content Standards above. Full format rules, metadata directives, note-writing standards, and mathematical rigor requirements for flashcards are documented in `.agents/skills/generate-flashcards/SKILL.md`, which specializes the Content Standards above for card granularity and phrasing; follow that skill when creating, editing, or reviewing flashcards.

## Self-Check Questions

`self-check.tex` is the entrypoint for the self-check questions PDF: a single top-level LaTeX document that recursively `\input`s each topic's `.tex` files into one compiled PDF of readable, conceptually clear questions for active recall and conceptual reinforcement, not passive exposition. Topic files are content fragments, not standalone documents; only `self-check.tex` is compiled directly. They follow the Content Standards above.

### Build Self-Check Questions

The root `Makefile` builds the compiled self-check PDF. It first runs `node self-check-stats.js`, which walks the topic files included from the top-level document and regenerates `self-check-stats.tex` — this step needs a host `node` install, unlike the LaTeX steps below, since it runs directly rather than inside the TeX Live container. It then compiles the top-level document with `latexmk` inside the TeX Live container (see "TeX Live via Podman" below), producing the PDF. Commit the regenerated `self-check-stats.tex` alongside content changes that add or remove questions.

## Essays

Essays are standalone `.tex` files in the `essays` directory, one per topic, each compiling to its own PDF. They are write-ups of deeper explorations of a topic — typically produced from a conversation — kept around so rereading them later reinforces the ideas.

### Build Essays

A `Makefile` in the `essays` directory builds every essay to its own PDF. It compiles each `.tex` file with `latexmk` inside the TeX Live container (see "TeX Live via Podman" below).

## TeX Live via Podman

No local TeX/Asymptote/Ghostscript install is assumed or required. All compilation and rendering runs inside the `texlive` docker image via `podman`, so the only host dependency for these steps is `podman` itself (able to pull `registry.gitlab.com/islandoftex/images/texlive:latest`). An example invocation of the texlive image is given below:

```sh
IMAGE = registry.gitlab.com/islandoftex/images/texlive:latest
DIR = ...
export SOURCE_DATE_EPOCH := 0
podman run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$DIR:/work:Z" -w /work "$IMAGE" \
  latexmk -pdf ...
```

- `--userns keep-id` maps the container user to the host user so files written into the bind mount (`-v "$DIR:/work:Z"`) are owned by the invoking user, not root.
- `-w /work` runs the command from the mounted directory.
- `SOURCE_DATE_EPOCH=0` is exported before the run and passed through with `-e` so pdfTeX embeds a fixed `/CreationDate`, `/ModDate`, and `/ID` instead of the wall-clock time. Built PDFs are committed alongside their sources, so a git- or clock-derived timestamp would make unrelated commits churn the embedded dates; pdfTeX reads this variable itself, no extra flags are needed. Rebuilding unchanged sources therefore produces byte-identical PDFs.

## Asymptote Illustrations

Vector illustrations are authored as Asymptote (`.asy`) source files.

The root `Makefile` finds every `.asy` file in the repo (excluding `common.asy` and build/vendor directories) and compiles each to its own `.svg`:

```sh
make illustrations
```

which runs, per file:

```sh
podman run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$DIR:/work:Z" -w /work "$IMAGE" \
  asy -f svg -render=0 -o "$name" "$name.asy"
```

- `asy -f svg -render=0` compiles the `.asy` source to a vector SVG, using `dvisvgm` (bundled in the texlive image) to typeset LaTeX labels as real vector glyphs rather than rasterizing them.
- `-o "$name"` sets the output path explicitly (Asymptote otherwise writes to the process's working directory rather than next to the input file); the podman invocation always runs from the repo root, so `$name` is the source's path relative to the repo root with the `.asy` extension stripped.
- `common.asy` at the repo root holds shared helpers imported by other `.asy` files (`import common;`), not a standalone illustration. It resolves from any subdirectory because Asymptote's import search checks the process's working directory, which is always the repo root here. It is tracked as a Makefile prerequisite of every illustration, so editing it rebuilds everything.
- Make's incremental rebuilds mean an unchanged `.asy` file is left alone; only sources newer than their `.svg` (or a changed `common.asy`) are re-rendered.
