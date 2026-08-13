---
name: generate-illustrations
description: Author and compile a math illustration in this repository — a 2D or 3D Asymptote (.asy) diagram. Use when asked to draw, illustrate, plot, render, or visualize a curve, surface, or geometric construction, or to build/compile/regenerate an existing .asy illustration.
---

# Generate Math Illustrations

## Purpose

Author an Asymptote diagram — 2D, or 3D — then compile it and verify the build output actually landed, before handing it back or referencing it from a `.note` file.

## Repository Context

Illustrations are one of the compiled-artifact steps in this repository (alongside PDF files); see `AGENTS.md` for the full repo overview. All compilation runs through `texlive.sh` at the repo root (see "TeX Live via `texlive.sh`" in `AGENTS.md`), which runs everything — LaTeX-only PDF builds, vector SVG illustrations, and raster PNG illustrations alike — inside a locally-built podman image with a bundled virtual display, plus a host `uv` install for the PNG transparent-background reconstruction step. See "TeX Live via `texlive.sh`" in `AGENTS.md` for the full rationale and one-time image build step.

## Where Sources Live

`.asy` sources are not confined to one directory, but all live under `flashcards/`. Each lives in an `img/` subdirectory beside the `.note` file it illustrates — e.g. an illustration for `01-algebra/some-topic.note` lives at `01-algebra/img/illustration.asy` — and compiles to a same-named `.svg` in that same `img/` directory. When a topic directory has no `img/` subdirectory yet, create one rather than placing the new source flat.

`common.asy` at the top of `flashcards/` holds shared helpers used across illustrations regardless of where they live — `import common;` resolves from any directory because compilation always runs with `flashcards/` as the working directory. Existing illustrations predate these helpers and have not been migrated to import them yet; new illustrations should reach for them where they fit (see Authoring below).

`common3d.asy`, alongside `common.asy`, holds the equivalent shared helpers for 3D scenes (camera/projection setup, projecting `triple`s to 2D, drawing flat fills safely, etc.) — import it the same way with `import common3d;`. See "Flat fills in 3D scenes" below before adding new 3D helpers here: the ones already in `common3d.asy` route all drawing through a single 2D projection helper specifically to avoid the `path3`/`size3` fill-duplication pitfall described there.

## Authoring

1. Look at 2-3 existing `.asy` files (anywhere in the repo) for the closest analog (a similar curve family or construction) and match their structure and style.
2. Use plain `size(...)`, `draw`, `label`, `dot` calls. Use shared helpers from `common.asy` (`import common;`) where they fit.
3. Name the file after the concept it illustrates, matching existing naming (snake_case, e.g. `unit_circle.asy`), and place it in the `img/` subdirectory beside the `.note` file it accompanies.

### LaTeX labels

`mathdefaults()` (in `common.asy`) loads `amsmath` via `texpreamble(...)`, so amsmath macros (`\text`, `\dfrac`, `\substack`, etc.) work in `label()` strings as long as the file calls `mathdefaults()` — which every current illustration does, directly or, for 3D scenes, via `import common3d;` (which itself imports `common`).

If a file skips `mathdefaults()` entirely, amsmath macros fail there in a misleading way: Asymptote runs a separate pdflatex pass per label first to compute its metrics, and when an undefined macro makes that pass error, it leaves a stale intermediate `.pdf` behind without regenerating the `.tex` the next compile stage expects. The visible failure is one step removed from the real cause and looks like a filesystem/mount problem rather than a LaTeX syntax error — e.g. `! I can't find file '<name>_.tex'` followed by `shipout failed`, with no mention of the macro anywhere. If you ever hit this, the fix is to call `mathdefaults()` (or add `texpreamble("\usepackage{amsmath}");` directly) before any `label()` calls.

### SVG vs. PNG output

By default an illustration compiles to a vector `.svg` (`asy -f svg -render=0`), which typesets labels as real vector glyphs and scales losslessly — this covers all 2D diagrams and simple 3D scenes (wireframes built from `draw`, `dot`, `label`, e.g. `import three;` with a plain `unitbox`).

Some 3D scenes can't be vectorized: shaded or rendered surfaces (`surface(...)`, `render(...)`, palette/color-mapped shading, lighting). Asymptote's SVG backend doesn't fail on these — it silently embeds a rasterized image inside the `.svg` wrapper, which is strictly worse than a real PNG (same raster content, extra XML overhead, and it lies about being vector).

Decide at authoring time: if the scene needs `surface`, `render`, or shading, add a directive comment near the top of the `.asy` source:

```
// output: png
```

This tells the Makefile to compile the file to a same-named `.png` instead of `.svg` (see Compile below). Leave the directive off for everything else — 2D diagrams and 3D wireframes — which stay the default vector SVG.

PNG output renders through Asymptote's hardware GL rasterizer (`-render` above 0), which needs a display — `texlive.sh`'s podman image bundles a virtual `Xvfb` display for exactly this, giving Asymptote's own default (`-render=2`) a real depth buffer that occludes multiple overlapping `surface()` draws correctly regardless of draw order. (Without a display, Asymptote falls back to `-render=0`, its software rasterizer, which does **not** reliably depth-sort across separate `draw()` calls — scenes with more than one overlapping 3D surface would render with wrong occlusion.) `flashcards/Makefile`'s `ASY_RENDER` variable controls the level (default `2`; override with e.g. `ASY_RENDER=4` if needed). `-render=0` output comes out at roughly a quarter the pixel density of higher `-render` settings. Since a raster PNG can't rescale losslessly the way SVG can, compensate by authoring 3D/PNG scenes at a larger physical `size(...)`/`size3(...)` than you would for a vector illustration — e.g. `size3(6cm,10cm,16cm)` rather than `size3(3cm,5cm,8cm)` — to land at an adequate final pixel resolution.

#### PNG output has a real transparent background

Asymptote's 3D PNG renderer has no way to output an alpha channel directly — its hardware rasterizer always composites onto an opaque background. `flashcards/Makefile`'s `%.png` rule works around this by rendering each scene _twice_ through `render-transparent-png.sh` (once with `currentlight.background = black;`, once `= white;`, injected right after the scene's `mathdefaults();` line) and difference-matting the pair into a real RGBA image (`flashcards/reconstruct-transparent-png.py`):

```
alpha = 1 - (white_render - black_render)   # averaged across R, G, B
rgb   = black_render / alpha                 # the recovered foreground color
```

This works even through several overlapping translucent surfaces (depth-buffered occlusion, multiple `draw(surface(...))` calls) — composing any stack of "over" blends against a common solid backdrop is still affine in that backdrop, so the same two-point solve recovers the correct _total_ alpha/color at each pixel regardless of how many layers or what order they occlude in. Reconstruction stays in sRGB/gamma space by default (not linear light): Asymptote's `-srgb` flag, which would render in linear space, defaults to `false`, so it already composites in gamma space — converting to linear first before reconstructing was measured to make per-channel alpha agreement _worse_ (roughly an order of magnitude, on the one scene this was checked against), not better, for this renderer specifically.

The consequences for authoring is that every `// output: png` scene must call `mathdefaults();` on its own bare line — that's the exact anchor `render-transparent-png.sh` injects after. A scene missing it fails the build loudly (not silently with an opaque background); if you hit this, add the call (see "LaTeX labels" above, which already requires it for a different reason).

### Flat fills in 3D scenes

A 3D scene that also needs a flat, translucent filled region (e.g. a plane through a curve) can't use `surface()` for that fill without triggering the raster fallback above. The tempting alternative — draw the wireframe normally with `path3`/`draw`, but compute the fill's corners by hand with `project()` and add them as a plain 2D `fill`/`filldraw` — is unsafe: Asymptote fits `path3` content (via `size3()`, at shipout) and plain 2D content in the same picture through separate mechanisms, and mixing them causes the manually-projected 2D fill to be silently emitted twice — once at the correct fitted scale, once more as a small stray duplicate near the fill's source point. The duplicate is easy to miss in a quick visual check (small preview, light zoom), since it's tiny and often lands right on top of existing artwork.

The safe pattern: for a 3D scene with any flat 2D fill, project _every_ element yourself — curve, vectors, labels, fills — through the same `project(triple, projection)` call, and don't use `path3`/`size3`/`Arrow3` in that scene at all. Fit the result with plain `size()`, exactly like any 2D illustration. See `flashcards/common3d.asy` (`proj()`, `drawHelix()`, `drawPlane()`) for a worked example.

## Preview

The Read tool cannot display `.svg` files as images, so for SVG-targeted illustrations the compiled deliverable itself can't be visually inspected directly. Before compiling the final `.svg`, render a raster preview and look at it:

```sh
make -C flashcards path/to/file.preview.png
```

This runs `asy -f png -render=$(ASY_RENDER)` on the `.asy` source directly, through the same `texlive.sh` invocation and render level used for the `%.png`/`%.svg` rules (see SVG vs. PNG output above) — Asymptote's own hardware-rendered default. The output lands next to the source as `<name>.preview.png`; it's gitignored, so it never needs manual cleanup, but treat it as scratch, not a deliverable. To remove every preview PNG under `flashcards/` at once, run `make -C flashcards clean-previews`.

View the PNG with the Read tool and check for: labels or elements overlapping, anything clipped by the canvas bounds, and shapes reading incorrectly (e.g. a rectangle that should visibly overshoot or undershoot a curve but doesn't). Iterate — edit the `.asy`, rerun `make -C flashcards path/to/file.preview.png`, re-view — until it's correct.

For scenes with overlapping or translucent fills, also sanity-check the compiled `.svg` source directly, not just the raster preview: count fill elements (e.g. `grep -c "opacity=" path/to/file.svg`) and confirm the count matches the number of filled shapes the source actually draws. A stray duplicate fill (see "Flat fills in 3D scenes" above) is often too small to notice by eye at preview resolution, but always shows up as an unexpected extra count.

For files with the `// output: png` directive, skip this step: the compiled deliverable is already a PNG the Read tool can view directly, so a separate `.preview.png` would be redundant work — just build and inspect the real target (`make -C flashcards path/to/file.png`), iterating directly on it. Note that `.preview.png` and the real `.png` target are _not_ interchangeable for these files: `.preview.png` always stays a single, fast, opaque render for quick layout iteration, while the real target additionally goes through the transparent-background reconstruction (see "PNG output has a real transparent background" above) — checking final appearance (e.g. compositing over a non-white backdrop) needs the real target, not the preview.

## Compile

The `flashcards/Makefile` finds every `.asy` file under `flashcards/` (excluding `common.asy`), splits them by whether they carry the `// output: png` directive (see SVG vs. PNG output above), and builds each to a same-named `.svg` or `.png`:

```sh
make -C flashcards
```

builds both `svg` and `png` targets (`all: svg png`). Per file, this runs one of:

```sh
../texlive.sh asy -f svg -render=0 -o "$name" "$name.asy"

./render-transparent-png.sh $(ASY_RENDER) "$name.asy" "$name.png"
```

- `asy -f svg -render=0` compiles the `.asy` source to a vector SVG, using `dvisvgm` (bundled in the texlive image) to typeset LaTeX labels as real vector glyphs rather than rasterizing them. SVG output doesn't go through the GL rasterizer, so `-render` doesn't affect it.
- `render-transparent-png.sh` renders the scene twice through `asy -f png -render=$(ASY_RENDER)` (background forced to black, then white) and reconstructs a transparent PNG from the pair via `reconstruct-transparent-png.py` — see "PNG output has a real transparent background" above for why, and what it requires of the source file.
- `-o "$name"` sets the output path explicitly (Asymptote otherwise writes to the process's working directory rather than next to the input file); `texlive.sh` always runs from `flashcards/`, so `$name` is the source's path relative to `flashcards/` with the `.asy`/`.svg`/`.png` extension stripped. `render-transparent-png.sh` follows the same convention for its own `<src.asy> <dest.png>` arguments.

To compile and check a single file, build its target directly — `.svg` by default, or `.png` if the source carries the `// output: png` directive (check the file first to know which), e.g. `make -C flashcards 01-algebra/unit_circle.svg` (path relative to `flashcards/`) — then verify the output exists before referencing it.

Incremental: only sources newer than their output (or newer than `common.asy`, tracked as a dependency of everything) are rebuilt.
