# Flycheck Coverity Checker

[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
[![MELPA](http://melpa.org/packages/flycheck-coverity-badge.svg)](http://melpa.org/#/flycheck-coverity)
[![Build Status](https://travis-ci.org/alexmurray/flycheck-coverity.svg?branch=master)](https://travis-ci.org/alexmurray/flycheck-coverity)

Integrate
[Coverity Desktop Analysis](http://www.coverity.com/why-coverity-developers/)
`cov-run-desktop` with [flycheck](http://www.flycheck.org) to automatically
check for defects in your code on-the-fly.

## Installation

### MELPA

The preferred way to install `flycheck-coverity` is via
[MELPA](http://melpa.org) - then you can just <kbd>M-x package-install RET
flycheck-coverity RET</kbd>

To enable then simply add the following to your init file:

```emacs-lisp
(with-eval-after-load 'flycheck
  (require 'flycheck-coverity)
  (flycheck-coverity-setup))
```

### Manual

If you would like to install the package manually, download or clone it and
place within Emacs' `load-path`, then you can require it in your init file like
this:

```emacs-lisp
(require 'flycheck-coverity)
(flycheck-coverity-setup)
```

NOTE: This will also require the manual installation of `flycheck` if you have
not done so already.

## License

Copyright © 2017 Alex Murray

Distributed under GNU GPL, version 3.
