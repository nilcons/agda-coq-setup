#!/bin/bash

set -eu

mkdir -p $HOME/.emacs.d

cat > $HOME/.emacs.d/install-package.el <<EOF
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; Fix HTTP/1.1 problems
(setq url-http-attempt-keepalives nil)
(package-refresh-contents)
(mapc 'package-install pkg-to-install)
EOF

emacs --batch --eval "(defconst pkg-to-install '(proof-general ivy counsel swiper use-package which-key haskell-mode ghc ghci-completion))" -l $HOME/.emacs.d/install-package.el
