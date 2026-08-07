PODMAN ?= podman
TEXLIVE_IMAGE ?= registry.gitlab.com/islandoftex/images/texlive:latest
export SOURCE_DATE_EPOCH := 0
TEXLIVE_RUN = $(PODMAN) run --rm -it --userns keep-id -e SOURCE_DATE_EPOCH -v "$(CURDIR):/work:Z" -w /work $(TEXLIVE_IMAGE)

ASY_SOURCES := $(shell find . -name '*.asy' -not -name 'common.asy' -print)
SVG_TARGETS := $(ASY_SOURCES:.asy=.svg)
COMMON_ASY := $(wildcard common.asy)

all: svg

svg: $(SVG_TARGETS)

%.svg: %.asy $(COMMON_ASY)
	$(TEXLIVE_RUN) asy -f svg -render=0 -o $(basename $@) $<

%.preview.png: %.asy $(COMMON_ASY)
	$(TEXLIVE_RUN) asy -f png -render=4 -o $(basename $@) $<

clean-previews:
	find . -name '*.preview.png' -delete

.PHONY: all svg clean-previews
