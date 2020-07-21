# Make comprehensive exam paper
papers/comps/comps-paper.pdf: papers/comps/comps-paper.md
	pandoc \
		-F pandoc-crossref	\
		-F pandoc-citeproc	\
		papers/comps/comps-paper.md -o papers/comps/comps-paper.pdf	\
		--toc

# Make manuscript
papers/joint-dd/manuscript.pdf: papers/joint-dd/manuscript.md
	pandoc \
		-F pandoc-crossref	\
		-F pandoc-citeproc	\
		papers/joint-dd/manuscript.md -o papers/joint-dd/manuscript.pdf
