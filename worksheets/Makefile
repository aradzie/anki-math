export SOURCE_DATE_EPOCH := 0
TEXLIVE_SH := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../texlive.sh)
TEXLIVE_RUN = $(TEXLIVE_SH)

AUXDIR := aux

TEX_SOURCES := $(wildcard *_worksheet.tex)
WORKSHEET_PDFS := $(TEX_SOURCES:.tex=.pdf)
SOLUTION_PDFS := $(patsubst %_worksheet.tex,%_solutions.pdf,$(TEX_SOURCES))
PDF_TARGETS := $(WORKSHEET_PDFS) $(SOLUTION_PDFS)

.PHONY: all clean cleanall
all: $(PDF_TARGETS)

%_worksheet.pdf: %_worksheet.tex worksheet.cls
	mkdir -p $(AUXDIR)
	$(TEXLIVE_RUN) latexmk -pdf -interaction=nonstopmode -halt-on-error -auxdir=$(AUXDIR) -outdir=. -jobname=$*_worksheet $<

%_solutions.pdf: %_worksheet.tex worksheet.cls
	mkdir -p $(AUXDIR)
	$(TEXLIVE_RUN) latexmk -pdf -interaction=nonstopmode -halt-on-error -auxdir=$(AUXDIR) -outdir=. -jobname=$*_solutions -usepretex="\def\solutions{1}" $<

clean:
	$(TEXLIVE_RUN) latexmk -c -auxdir=$(AUXDIR) -outdir=. $(TEX_SOURCES)

cleanall:
	$(TEXLIVE_RUN) latexmk -C -auxdir=$(AUXDIR) -outdir=. $(TEX_SOURCES)
