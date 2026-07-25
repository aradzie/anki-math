# Render *.py illustrations (PyVista, via the repo's uv project) to PNG, and
# *.asy illustrations (Asymptote, via the texlive podman image) to PDF + SVG.
#
# common.py / common.asy hold shared helpers, not standalone illustrations,
# but are tracked as dependencies so editing them rebuilds everything.

PODMAN ?= podman
TEXLIVE_IMAGE ?= registry.gitlab.com/islandoftex/images/texlive:latest
export SOURCE_DATE_EPOCH := 0

ROOT := $(abspath ..)
ASY_RUN = $(PODMAN) run --rm --userns keep-id -e SOURCE_DATE_EPOCH -v "$(CURDIR):/work:Z" -w /work $(TEXLIVE_IMAGE) asy

COMMON_PY := $(wildcard common.py)
COMMON_ASY := $(wildcard common.asy)

PY_SOURCES := $(filter-out common.py,$(wildcard *.py))
ASY_SOURCES := $(filter-out common.asy,$(wildcard *.asy))

PNG_TARGETS := $(PY_SOURCES:.py=.png)
PDF_TARGETS := $(ASY_SOURCES:.asy=.pdf)
SVG_TARGETS := $(ASY_SOURCES:.asy=.svg)

.PHONY: all clean
all: $(PNG_TARGETS) $(PDF_TARGETS) $(SVG_TARGETS)

%.png: %.py $(COMMON_PY)
	uv run --project $(ROOT) $<

%.pdf: %.asy $(COMMON_ASY)
	$(ASY_RUN) -f pdf -render=0 $<

%.svg: %.asy $(COMMON_ASY)
	$(ASY_RUN) -f svg -render=0 $<

clean:
	rm -f $(PNG_TARGETS) $(PDF_TARGETS) $(SVG_TARGETS)
