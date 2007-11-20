# contents: ZAP Makefile.
#
# Copyright © 2006 Nikolai Weibull <now@bitwi.se>

SHELL = /bin/zsh

INSTALL = install

DEST = $(shell print - $$fpath[(r)$${ZDOTDIR:-$$HOME/.zsh}/functions])
ifeq ($(DEST),)
$(error Please set up your $$fpath to include a directory in your $$HOME)
endif

DIRS = \
       zap \
       zap/format \
       zap/path

FILES = \
	zap/create-temporary-file \
	zap/error \
	zap/file-is-regular-and-readable \
	zap/format/columns \
	zap/init \
	zap/math \
	zap/parse-options \
	zap/path/common-prefix \
	zap/pattern/escape \
	zap/try-help

dest_DIRS = $(addprefix $(DEST)/,$(DIRS))
dest_FILES = $(addprefix $(DEST)/,$(FILES))

.PHONY: all install uninstall

all:
	@echo Use “make install” to install files.

install: $(dest_DIRS) $(dest_FILES)

$(DEST)/%: %
	$(INSTALL) --mode=644 $< $@

$(dest_DIRS):
	$(INSTALL) --directory --mode=755 $@

uninstall:
	rm $(dest_FILES)
	rmdir $(dest_DIRS)
