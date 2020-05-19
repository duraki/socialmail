SOCIALMAIL_KERNEL=socialmail

PL=crystal
CR=shards

BINDIR=bin

CC=gcc

shards:
	$(CR) build

release:
	$(PL) build src/socialmail.cr --release --cross-compile

socialmail:
	$(PL) build src/socialmail.cr --release --cross-compile

fast:
	$(PL) build -s -p src/socialmail.cr -o bin/socialmail

test:
	$(PL) spec

clean:
	rm -rf bin/*