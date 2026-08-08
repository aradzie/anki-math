PODMAN ?= podman
TEXLIVE_IMAGE ?= registry.gitlab.com/islandoftex/images/texlive:latest
export SOURCE_DATE_EPOCH := 0
TEXLIVE_RUN = $(PODMAN) run --rm -it --userns keep-id -e SOURCE_DATE_EPOCH -v "$(CURDIR):/work:Z" -w /work $(TEXLIVE_IMAGE)

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
	$(TEXLIVE_RUN) asy -f png -render=0 -o $(basename $@) $<

%.preview.png: %.asy $(COMMON_ASY)
	$(TEXLIVE_RUN) asy -f png -render=0 -o $(basename $@) $<

clean-previews:
	find . -name '*.preview.png' -delete

.PHONY: all svg png clean-previews
