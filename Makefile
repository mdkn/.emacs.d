check:
	emacs -batch -l ~/.emacs.d/init.el 2>&1 | tee check.log | tail -1

build:
	emacs --batch -f batch-byte-compile init.el | tee build.log
