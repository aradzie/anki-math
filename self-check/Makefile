PODMAN ?= podman
TEXLIVE_IMAGE ?= registry.gitlab.com/islandoftex/images/texlive:latest
export SOURCE_DATE_EPOCH := 0
TEXLIVE_RUN = $(PODMAN) run --rm -it --userns keep-id -e SOURCE_DATE_EPOCH -v "$(CURDIR):/work:Z" -w /work $(TEXLIVE_IMAGE)

AUXDIR := aux

all: pdf

pdf:
	node self-check-stats.js
	mkdir -p $(AUXDIR)
	$(TEXLIVE_RUN) latexmk -pdf -auxdir=$(AUXDIR) -outdir=. self-check.tex

clean:
	$(TEXLIVE_RUN) latexmk -c -auxdir=$(AUXDIR) -outdir=.

cleanall:
	$(TEXLIVE_RUN) latexmk -C -auxdir=$(AUXDIR) -outdir=.

.PHONY: all pdf clean cleanall
