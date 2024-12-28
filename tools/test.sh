#!/bin/sh
emacs -batch -l init.el 2>&1 | tee check.log | tail -1 | if ( grep "^End of loading init.el.$" > /dev/null ); then echo "Test Passed"; exit 0; else echo "Test Failed"; exit 1; fi
