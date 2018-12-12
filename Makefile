PKG_NAME := cnf
ARCHIVES = 

include ../common/Makefile.common

update:
	python commandnotfound-list.py | sort > commandlist.csv
	git diff --exit-code  commandlist.csv || git commit -m "update command list" commandlist.csv ; make bump ; make koji
