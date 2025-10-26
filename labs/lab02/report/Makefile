.PHONY: all clean

all: report.md report.pdf report.docx

report.md: arch-pc--lab02--report.qmd
	pandoc arch-pc--lab02--report.qmd -o report.md

report.pdf: arch-pc--lab02--report.qmd
	pandoc arch-pc--lab02--report.qmd -o report.pdf --pdf-engine=xelatex -V mainfont="DejaVu Serif"

report.docx: arch-pc--lab02--report.qmd
	pandoc arch-pc--lab02--report.qmd -o report.docx

clean:
	rm -f report.md report.pdf report.docx

