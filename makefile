LATEX=latexmk
TARGET=_main.pdf
SRCS:=$(shell find . -name "*.tex")

DFFLAG=-xelatex -interaction=nonstopmode
RFLAG=-quiet
DFLAG=-pv

debug:
	$(LATEX) $(DFFLAG) $(DFLAG) $(TARGET:.pdf=.tex)
release:
	$(LATEX) $(DFFLAG) $(RFLAG) $(TARGET:.pdf=.tex)
	$(LATEX) -c
clean:
	$(LATEX) -C
