SHELL = /bin/sh
EMACS ?= emacs
BATCH_OPTS = --batch
RM = @rm -rf

.PHONY: clean check build

clean:
	$(RM) *~
	$(RM) \#*\#
	$(RM) *.elc
	$(RM) check.log clean.log

check:
	@echo "Running smoke test..."
	@chmod +x tools/test.sh
	@./tools/test.sh

build: clean
	@$(EMACS) $(BATCH_OPTS) -f batch-byte-compile init.el | tee build.log | tail -1
