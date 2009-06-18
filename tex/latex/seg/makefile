help:
	@echo "Available makes:"
	@echo "all abs eabs gp gpe gp2c clean cleanall"

all:
	make abs
	make eabs
	make gp
	make gpe
	make gp2c

# SEG abstract example (default)
abs:
	pdflatex segabs_example.ltx
	bibtex   segabs_example
	pdflatex segabs_example.ltx
	pdflatex segabs_example.ltx
	pdflatex segabs_final.ltx

# EAGE abstract example
eabs:
	pdflatex eage_example.ltx
	bibtex   eage_example
	pdflatex eage_example.ltx
	pdflatex eage_example.ltx

# Geophysics example
gp:
	pdflatex geophysics_example.ltx
	bibtex   geophysics_example
	pdflatex geophysics_example.ltx
	pdflatex geophysics_example.ltx

# Geophysics end float example
gpe:
	pdflatex geophysics_endfloat.ltx
	bibtex   geophysics_endfloat
	pdflatex geophysics_endfloat.ltx
	pdflatex geophysics_endfloat.ltx

# Geophysics two-column example
gp2c:
	pdflatex geophysics_twocolumn.ltx
	bibtex   geophysics_twocolumn
	pdflatex geophysics_twocolumn.ltx
	pdflatex geophysics_twocolumn.ltx

clean:
	rm *.aux *.bbl *.blg *.log 

cleanall:
	rm *.aux *.bbl *.blg *.log *.pdf

