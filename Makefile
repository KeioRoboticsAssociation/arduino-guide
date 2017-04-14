out.html: *.md
	pandoc *.md \
		--standalone \
		--from markdown+east_asian_line_breaks \
		--css css/github-pandoc.css \
		--css css/custom.css \
		--output out.html
clean:
	rm out.*

