.PHONY: watch unwatch all

BASE_NAME=diagram

all: $(addprefix $(BASE_NAME)., pdf svg)

watch:
	while inotifywait -e close_write $(BASE_NAME).dot; do make all; done \
	& echo "$$!" > watch.pid

unwatch:
	[ -f watch.pid ] || { echo No pid file found >&2; exit -1; }
	kill `cat watch.pid` $$(pgrep -P `cat watch.pid`)
	rm watch.pid

define DOT
tgt="$@"; dot -T$${tgt##*.} -o "$@" "$<"
endef

%.svg: %.dot
	$(DOT)

%.pdf: %.dot
	$(DOT)
