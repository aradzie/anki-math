export SOURCE_DATE_EPOCH := 0
TEXLIVE_SH := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../texlive.sh)
TEXLIVE_RUN = $(TEXLIVE_SH)

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
