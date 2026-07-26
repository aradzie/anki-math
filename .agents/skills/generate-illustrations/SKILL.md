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

## Compile

The root `Makefile` finds every `.asy` file in the repo (excluding `common.asy` and build/vendor directories) and builds it to a same-named `.svg`:

```sh
make illustrations
```

To compile and check a single file, build its `.svg` target directly, e.g. `make illustrations/unit_circle.svg`, then verify the output exists and is a valid SVG before referencing it.

Incremental: only sources newer than their output (or newer than `common.asy`, tracked as a dependency of everything) are rebuilt.
