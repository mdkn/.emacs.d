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
	@$(EMACS) $(BATCH_OPTS) -l init.el 2>&1 | tee check.log | tail -1

build: clean
	@$(EMACS) $(BATCH_OPTS) -f batch-byte-compile init.el | tee build.log | tail -1
