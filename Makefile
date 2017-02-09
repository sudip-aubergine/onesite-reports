TODAY_DATE := $(shell date +%Y-%m-%d)

report:
	./report.sh

setreportdir:
	@mkdir ${TODAY_DATE}

clean:
	rm -f onesite.log business.txt
