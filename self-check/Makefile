export SOURCE_DATE_EPOCH := 0
TEXLIVE_SH := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../texlive.sh)
TEXLIVE_RUN = $(TEXLIVE_SH)

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
