---
name: generate-illustrations
description: Author and compile a math illustration in this repository — a 2D or 3D Asymptote (.asy) diagram. Use when asked to draw, illustrate, plot, render, or visualize a curve, surface, or geometric construction, or to build/compile/regenerate an existing .asy illustration.
---

# Generate Math Illustrations

## Purpose

Author an Asymptote diagram — 2D, or 3D — then compile it and verify the build output actually landed, before handing it back or referencing it from a `.note` file.

## Repository Context

Illustrations are one of the compiled-artifact steps in this repository (alongside PDF files); see `AGENTS.md` for the full repo overview. All compilation runs inside the `texlive` podman image — no local TeX/Asymptote install is required or assumed.

## Where Sources Live

`.asy` sources are not confined to one directory, but all live under `flashcards/`. Each lives in an `img/` subdirectory beside the `.note` file it illustrates — e.g. an illustration for `01-algebra/some-topic.note` lives at `01-algebra/img/illustration.asy` — and compiles to a same-named `.svg` in that same `img/` directory. When a topic directory has no `img/` subdirectory yet, create one rather than placing the new source flat.

`common.asy` at the top of `flashcards/` holds shared helpers used across illustrations regardless of where they live — `import common;` resolves from any directory because compilation always runs with `flashcards/` as the working directory. Existing illustrations predate these helpers and have not been migrated to import them yet; new illustrations should reach for them where they fit (see Authoring below).

`common3d.asy`, alongside `common.asy`, holds the equivalent shared helpers for 3D scenes (camera/projection setup, projecting `triple`s to 2D, drawing flat fills safely, etc.) — import it the same way with `import common3d;`. See "Flat fills in 3D scenes" below before adding new 3D helpers here: the ones already in `common3d.asy` route all drawing through a single 2D projection helper specifically to avoid the `path3`/`size3` fill-duplication pitfall described there.

## Authoring

1. Look at 2-3 existing `.asy` files (anywhere in the repo) for the closest analog (a similar curve family or construction) and match their structure and style.
2. Use plain `size(...)`, `draw`, `label`, `dot` calls. Use shared helpers from `common.asy` (`import common;`) where they fit.
3. Name the file after the concept it illustrates, matching existing naming (snake_case, e.g. `unit_circle.asy`), and place it in the `img/` subdirectory beside the `.note` file it accompanies.

### SVG vs. PNG output

By default an illustration compiles to a vector `.svg` (`asy -f svg -render=0`), which typesets labels as real vector glyphs and scales losslessly — this covers all 2D diagrams and simple 3D scenes (wireframes built from `draw`, `dot`, `label`, e.g. `import three;` with a plain `unitbox`).

Some 3D scenes can't be vectorized: shaded or rendered surfaces (`surface(...)`, `render(...)`, palette/color-mapped shading, lighting). Asymptote's SVG backend doesn't fail on these — it silently embeds a rasterized image inside the `.svg` wrapper, which is strictly worse than a real PNG (same raster content, extra XML overhead, and it lies about being vector).

Decide at authoring time: if the scene needs `surface`, `render`, or shading, add a directive comment near the top of the `.asy` source:

```
// output: png
```

This tells the Makefile to compile the file to a same-named `.png` instead of `.svg` (see Compile below). Leave the directive off for everything else — 2D diagrams and 3D wireframes — which stay the default vector SVG.

PNG output (and any raster preview of SVG-targeted 3D content) always renders with `-render=0` — the texlive container has no display, and Asymptote's GL-based rasterizer (any `-render` above 0) needs one, so `-render=0` is the only rasterization mode that works with just podman. It comes out at roughly a quarter the pixel density of `-render` at higher settings. Since a raster PNG can't rescale losslessly the way SVG can, compensate by authoring 3D/PNG scenes at a larger physical `size(...)`/`size3(...)` than you would for a vector illustration — e.g. `size3(6cm,10cm,16cm)` rather than `size3(3cm,5cm,8cm)` — to land at an adequate final pixel resolution.

### Flat fills in 3D scenes

A 3D scene that also needs a flat, translucent filled region (e.g. a plane through a curve) can't use `surface()` for that fill without triggering the raster fallback above. The tempting alternative — draw the wireframe normally with `path3`/`draw`, but compute the fill's corners by hand with `project()` and add them as a plain 2D `fill`/`filldraw` — is unsafe: Asymptote fits `path3` content (via `size3()`, at shipout) and plain 2D content in the same picture through separate mechanisms, and mixing them causes the manually-projected 2D fill to be silently emitted twice — once at the correct fitted scale, once more as a small stray duplicate near the fill's source point. The duplicate is easy to miss in a quick visual check (small preview, light zoom), since it's tiny and often lands right on top of existing artwork.

The safe pattern: for a 3D scene with any flat 2D fill, project *every* element yourself — curve, vectors, labels, fills — through the same `project(triple, projection)` call, and don't use `path3`/`size3`/`Arrow3` in that scene at all. Fit the result with plain `size()`, exactly like any 2D illustration. See `flashcards/common3d.asy` (`proj()`, `drawHelix()`, `drawPlane()`) for a worked example.

## Preview

The Read tool cannot display `.svg` files as images, so for SVG-targeted illustrations the compiled deliverable itself can't be visually inspected directly. Before compiling the final `.svg`, render a raster preview and look at it:

```sh
make -C flashcards path/to/file.preview.png
```

This runs `asy -f png -render=0` on the `.asy` source directly, inside the same texlive container used for the `%.svg` rule below — no extra host dependency (in particular, no display, which is why `-render=0` is used — see SVG vs. PNG output above). The output lands next to the source as `<name>.preview.png`; it's gitignored, so it never needs manual cleanup, but treat it as scratch, not a deliverable. To remove every preview PNG under `flashcards/` at once, run `make -C flashcards clean-previews`.

View the PNG with the Read tool and check for: labels or elements overlapping, anything clipped by the canvas bounds, and shapes reading incorrectly (e.g. a rectangle that should visibly overshoot or undershoot a curve but doesn't). Iterate — edit the `.asy`, rerun `make -C flashcards path/to/file.preview.png`, re-view — until it's correct.

For scenes with overlapping or translucent fills, also sanity-check the compiled `.svg` source directly, not just the raster preview: count fill elements (e.g. `grep -c "opacity=" path/to/file.svg`) and confirm the count matches the number of filled shapes the source actually draws. A stray duplicate fill (see "Flat fills in 3D scenes" above) is often too small to notice by eye at preview resolution, but always shows up as an unexpected extra count.

For files with the `// output: png` directive, skip this step: the compiled deliverable is already a PNG the Read tool can view directly, and it renders with the same settings a preview would use, so a separate `.preview.png` would be redundant work. Just build and inspect the real target (`make -C flashcards path/to/file.png`), iterating directly on it.

## Compile

The `flashcards/Makefile` finds every `.asy` file under `flashcards/` (excluding `common.asy`), splits them by whether they carry the `// output: png` directive (see SVG vs. PNG output above), and builds each to a same-named `.svg` or `.png`:

```sh
make -C flashcards
```

builds both `svg` and `png` targets (`all: svg png`). Per file, this runs one of:

```sh
podman run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$DIR:/work:Z" -w /work "$IMAGE" \
  asy -f svg -render=0 -o "$name" "$name.asy"

podman run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$DIR:/work:Z" -w /work "$IMAGE" \
  asy -f png -render=0 -o "$name" "$name.asy"
```

- `asy -f svg -render=0` compiles the `.asy` source to a vector SVG, using `dvisvgm` (bundled in the texlive image) to typeset LaTeX labels as real vector glyphs rather than rasterizing them.
- `asy -f png -render=0` rasterizes the scene directly to a PNG, for files carrying the `// output: png` directive (see SVG vs. PNG output above for why `-render=0`).
- `-o "$name"` sets the output path explicitly (Asymptote otherwise writes to the process's working directory rather than next to the input file); the podman invocation always runs from `flashcards/`, so `$name` is the source's path relative to `flashcards/` with the `.asy`/`.svg`/`.png` extension stripped.

To compile and check a single file, build its target directly — `.svg` by default, or `.png` if the source carries the `// output: png` directive (check the file first to know which), e.g. `make -C flashcards 01-algebra/unit_circle.svg` (path relative to `flashcards/`) — then verify the output exists before referencing it.

Incremental: only sources newer than their output (or newer than `common.asy`, tracked as a dependency of everything) are rebuilt.
