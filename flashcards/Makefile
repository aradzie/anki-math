export SOURCE_DATE_EPOCH := 0
TEXLIVE_SH := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../texlive.sh)
TEXLIVE_RUN = $(TEXLIVE_SH)

# GL-rendered (hardware-depth-buffered) PNG output needs a display: the
# podman backend runs in a container with none, so it's forced to
# -render=0, Asymptote's software rasterizer -- which does not reliably
# depth-sort across separate draw() calls, so scenes with several
# overlapping 3D surfaces (e.g. quad_*.asy) render with wrong occlusion
# under podman. The toolbox/system backends share the host display, so
# they default to Asymptote's own -render default (2) for correct
# hardware depth buffering. Override explicitly with e.g. `ASY_RENDER=4`
# if needed; use `TEXLIVE_BACKEND=toolbox make -C flashcards png` to
# build multi-surface PNG scenes correctly.
TEXLIVE_BACKEND ?= podman
ASY_RENDER ?= $(if $(filter podman,$(TEXLIVE_BACKEND)),0,2)

ASY_SOURCES := $(shell find . -name '*.asy' -not -name 'common.asy' -not -name 'common3d.asy' -print)
PNG_SOURCES := $(shell grep -l '^// output: png' $(ASY_SOURCES) 2>/dev/null)
SVG_SOURCES := $(filter-out $(PNG_SOURCES),$(ASY_SOURCES))
SVG_TARGETS := $(SVG_SOURCES:.asy=.svg)
PNG_TARGETS := $(PNG_SOURCES:.asy=.png)
COMMON_ASY := $(wildcard common.asy common3d.asy)

all: svg png

svg: $(SVG_TARGETS)

png: $(PNG_TARGETS)

%.svg: %.asy $(COMMON_ASY)
	$(TEXLIVE_RUN) asy -f svg -render=0 -o $(basename $@) $<

%.png: %.asy $(COMMON_ASY)
	$(TEXLIVE_RUN) asy -f png -render=$(ASY_RENDER) -o $(basename $@) $<

%.preview.png: %.asy $(COMMON_ASY)
	$(TEXLIVE_RUN) asy -f png -render=$(ASY_RENDER) -o $(basename $@) $<

clean-previews:
	find . -name '*.preview.png' -delete

.PHONY: all svg png clean-previews
