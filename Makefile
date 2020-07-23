# Make manuscript (md to pdf)
papers/manuscript.pdf: papers/manuscript.md
	pandoc \
		-F pandoc-crossref	\
		-F pandoc-citeproc	\
		papers/manuscript.md -o papers/manuscript.pdf	\
	
