PROJECT=uq_talk
TEX=pdflatex
BIBTEX=bibtex
BUILDTEX=$(TEX) $(PROJECT).tex

# commit string of old file you want to diff current against
# (set as param to make: $ make diff DIFF_OLD=e727bd4)
# default to current commit
DIFF_OLD=HEAD

full: all

all:
	$(BUILDTEX)
	$(BIBTEX) $(PROJECT)
	$(BUILDTEX)
	$(BUILDTEX)

diff:
	git show $(DIFF_OLD):$(PROJECT).tex > $(PROJECT)_old.tex
	latexdiff $(PROJECT)_old.tex $(PROJECT).tex > changes.tex
	$(TEX) changes
	$(BIBTEX) changes
	$(TEX) changes
	$(TEX) changes
	rm toyota_report_old.tex changes.tex

clean-all:
	rm -f *.dvi *.log *.bak *.aux *.bbl *.blg *.idx *.ps *.eps *.pdf *.toc *.out *~

clean:
	rm -f *.log *.bak *.aux *.bbl *.blg *.idx *.toc *.out *~


