#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv
    brew install cmake || true
    brew install readline openssl xz

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi
    
    CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install -v 2.7.16
    pyenv virtualenv -f 2.7.16 conan
    pyenv rehash
    pyenv activate conan
fi

pip install conan --upgrade
pip install conan_package_tools

conan user
