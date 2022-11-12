.PHONY: watch all

BASE_NAME=diagram

watch:
	while inotifywait -e close_write $(BASE_NAME).dot; do make all; done &

all: $(BASE_NAME).svg $(BASE_NAME).pdf

%.svg: %.dot
	dot -Tsvg -o "$@" "$<"

%.pdf: %.dot
	dot -Tpdf -o "$@" "$<"
