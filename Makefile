out.html: src/*.md
	pandoc src/*.md \
		--standalone \
		--from markdown+east_asian_line_breaks \
		--css src/css/github-pandoc.css \
		--css src/css/custom.css \
		--output out.html
clean:
	rm dist/out.*

