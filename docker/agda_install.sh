#!/bin/bash

set -euo pipefail

agda_version=2.6.1
agda_stdlib_version=1.3
ghc_version=8.8.3

# Workaround for a Happy bug/misfeature. With the default locale, Happy does
# not recognise UTF-8 files.
export LC_ALL=C.UTF-8

stack_setup() {
    stack config set system-ghc --global true
    stack config set install-ghc --global false
}

stack_setup

mkdir -p ~/.agda
cd ~/.agda
git clone --depth 1 -b "v${agda_version}" https://github.com/agda/agda.git src
stack --stack-yaml src/stack-"${ghc_version}".yaml install -j1
stack --stack-yaml src/stack-"${ghc_version}".yaml clean

agda-mode compile

git clone --depth 1 -b "v${agda_stdlib_version}" https://github.com/agda/agda-stdlib.git ~/.agda/stdlib
cd ~/.agda/stdlib
stack --resolver "ghc-${ghc_version}" script --package filemanip --package filepath --package unix-compat --package directory --system-ghc -- GenerateEverything.hs
cp Everything.agda src/
agda --verbose=0 src/Everything.agda
rm src/Everything.agda _build/${agda_version}/agda/src/Everything.agdai

echo $HOME/.agda/stdlib/standard-library.agda-lib > ~/.agda/libraries

################################################################################
## Cleanup

rm -rf ~/.stack
stack_setup
