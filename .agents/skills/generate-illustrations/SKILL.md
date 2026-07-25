---
name: generate-illustrations
description: Author and compile a math illustration in this repository — a 2D Asymptote (.asy) diagram or a 3D PyVista (.py) surface plot in illustrations/. Use when asked to draw, illustrate, plot, render, or visualize a curve, surface, or geometric construction, or to build/compile/regenerate an existing .asy or .py illustration.
---

# Generate Math Illustrations

## Purpose

Author a vector 2D diagram (Asymptote) or a raster 3D surface plot (PyVista) in `illustrations/`, then compile it and verify the build output actually landed, before handing it back or referencing it from a `.tex` file.

## Repository Context

Illustrations are one of the compiled-artifact steps in this repository (alongside the self-check PDF and essays); see `AGENTS.md` for the full repo overview. All compilation runs inside the `texlive` podman image or the repo's `uv` project — no local TeX/Asymptote/PyVista install is required or assumed.

## Choosing 2D vs 3D

- **2D** (planar curves, geometric constructions, plane diagrams — e.g. `unit_circle.asy`, `mean_value_theorem.asy`, `rolle_theorem.asy`): Asymptote, source is `illustrations/<name>.asy`, compiles to `<name>.pdf` (embedded via `\includegraphics` in LaTeX) and `<name>.svg` (vector preview).
- **3D** (quadric surfaces and other 3D scenes — e.g. `ellipsoid.py`, `hyperboloid_one_sheet.py`): PyVista, source is `illustrations/<name>.py`, compiles to `<name>.png` only (raster; PyVista does real z-buffered rendering, so occlusion/transparency need no manual draw-order bookkeeping, but there is no vector output and axis labels are plain text, not LaTeX-typeset).

## Authoring

1. Look at 2-3 existing `.asy` or `.py` files in `illustrations/` for the closest analog (a similar curve family, or another quadric surface) and match their structure and style.
2. For Asymptote: use plain `size(...)`, `draw`, `label`, `dot` calls. Use shared helpers from `common.asy`.
3. For PyVista: Use shared helpers from `common.py`.
4. Name the file after the concept it illustrates, matching existing naming (snake_case, e.g. `elliptic_paraboloid.py`).

## Compile and Verify (agent path)

Run the driver after authoring or editing a source file — it compiles just that one illustration through the real pipeline (podman/Asymptote or uv/PyVista) and checks the output file exists, is non-empty, and is the right format:

```sh
bash .agents/skills/generate-illustrations/check-illustration.sh <name>
```

`<name>` is the basename with no extension (e.g. `ellipsoid`, `unit_circle`), resolved relative to `illustrations/`. Run it from anywhere in the repo. It exits non-zero on any compile failure or missing/malformed output, printing the podman/uv/make output that failed.

Verified this session, from repo root:

```sh
$ bash .agents/skills/generate-illustrations/check-illustration.sh unit_circle
OK: unit_circle.pdf (6705 bytes, PDF document, version 1.5, 1 page(s))
OK: unit_circle.svg (14231 bytes, SVG Scalable Vector Graphics image, ASCII text, with very long lines (1529))
```

A fresh `.asy` scratch source compiled the same way produced a valid 1-page PDF and SVG; a fresh `.py` scratch source (reusing `common.py`, same shape as `ellipsoid.py`) produced a valid 1280x1280 RGBA PNG. A name with no matching `.asy`/`.py` source fails loudly (`FAIL: no illustrations/<name>.asy or illustrations/<name>.py found`, exit 1) instead of silently doing nothing.

## Compile (human path)

To rebuild every illustration in the directory instead of just one:

```sh
cd illustrations && make
```

Incremental: `make` only rebuilds sources newer than their output (or newer than `common.py`/`common.asy`, which are tracked as dependencies of everything).

## Gotchas

- `make <name>.pdf` on a file that's already up to date prints `make: '<name>.pdf' is up to date.` and exits 0 without recompiling — this is expected, not a failure; the driver's file checks still confirm the existing output is valid.
- PyVista output has no vector/PDF form and its axis labels are plain text (not LaTeX-rendered math), unlike the Asymptote path's SVG with real vector glyphs for labels.

## After Compiling

Commit the generated `.pdf`/`.svg` (Asymptote) or `.png` (PyVista) alongside its source — builds from unchanged sources are byte-identical (`SOURCE_DATE_EPOCH=0` is set for the TeX Live/Asymptote path).
