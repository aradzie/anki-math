PODMAN ?= podman
TEXLIVE_IMAGE ?= registry.gitlab.com/islandoftex/images/texlive:latest
export SOURCE_DATE_EPOCH := 0
TEXLIVE_RUN = $(PODMAN) run --rm -it --userns keep-id -e SOURCE_DATE_EPOCH -v "$(CURDIR):/work:Z" -w /work $(TEXLIVE_IMAGE)

AUXDIR := aux

TEX_SOURCES := $(wildcard *.tex)
PDF_TARGETS := $(TEX_SOURCES:.tex=.pdf)

.PHONY: all clean cleanall
all: $(PDF_TARGETS)

%.pdf: %.tex essay.cls
	mkdir -p $(AUXDIR)
	$(TEXLIVE_RUN) latexmk -pdf -interaction=nonstopmode -halt-on-error -auxdir=$(AUXDIR) -outdir=. $<

clean:
	$(TEXLIVE_RUN) latexmk -c -auxdir=$(AUXDIR) -outdir=. $(TEX_SOURCES)

cleanall:
	$(TEXLIVE_RUN) latexmk -C -auxdir=$(AUXDIR) -outdir=. $(TEX_SOURCES)
