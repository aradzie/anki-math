---
name: generate-illustrations
description: Author and compile a math illustration in this repository — a 2D Asymptote (.asy) diagram. Use when asked to draw, illustrate, plot, render, or visualize a curve, surface, or geometric construction, or to build/compile/regenerate an existing .asy illustration.
---

# Generate Math Illustrations

## Purpose

Author a vector 2D diagram (Asymptote), then compile it and verify the build output actually landed, before handing it back or referencing it from a `.note` file.

## Repository Context

Illustrations are one of the compiled-artifact steps in this repository (alongside PDF files); see `AGENTS.md` for the full repo overview. All compilation runs inside the `texlive` podman image — no local TeX/Asymptote install is required or assumed.

## Where Sources Live

`.asy` sources are not confined to one directory. Each lives next to the content it illustrates — typically beside the `.note` file that will reference it — and compiles to a same-named `.svg` in that same directory.

`common.asy` at the repo root holds shared helpers used across illustrations regardless of where they live — `import common;` resolves from any directory because compilation always runs with the repo root as the working directory.

## Authoring

1. Look at 2-3 existing `.asy` files (anywhere in the repo) for the closest analog (a similar curve family or construction) and match their structure and style.
2. Use plain `size(...)`, `draw`, `label`, `dot` calls. Use shared helpers from `common.asy` (`import common;`).
3. Name the file after the concept it illustrates, matching existing naming (snake_case, e.g. `unit_circle.asy`), and place it next to the `.note` file it accompanies.

## Preview

The Read tool cannot display `.svg` files as images, so the compiled deliverable itself can't be visually inspected. Before compiling the final `.svg` or referencing an illustration from a `.note` file, render a raster preview and look at it:

```sh
make path/to/file.preview.png
```

This runs `asy -f png -render=4` on the `.asy` source directly, inside the same texlive container used for the `%.svg` rule below — no extra host dependency. The output lands next to the source as `<name>.preview.png`; it's gitignored, so it never needs manual cleanup, but treat it as scratch, not a deliverable.

View the PNG with the Read tool and check for: labels or elements overlapping, anything clipped by the canvas bounds, and shapes reading incorrectly (e.g. a rectangle that should visibly overshoot or undershoot a curve but doesn't). Iterate — edit the `.asy`, rerun `make path/to/file.preview.png`, re-view — until it's correct.

## Compile

The root `Makefile` finds every `.asy` file in the repo (excluding `common.asy` and build/vendor directories) and builds it to a same-named `.svg`:

```sh
make illustrations
```

To compile and check a single file, build its `.svg` target directly, e.g. `make unit_circle.svg` (path relative to the repo root — `illustrations` above is a phony aggregate target, not a directory), then verify the output exists before referencing it.

Incremental: only sources newer than their output (or newer than `common.asy`, tracked as a dependency of everything) are rebuilt.
