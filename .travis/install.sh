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
    
    export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
    export CFLAGS="-I$(brew --prefix readline)/include $CFLAGS" 
    export LDFLAGS="-L$(brew --prefix readline)/lib $LDFLAGS"
    export CFLAGS="-I$(brew --prefix openssl)/include $CFLAGS"
    export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
    pyenv install -s 3.7.2
    pyenv virtualenv -f 3.7.2 conan
    pyenv rehash
    pyenv activate conan
fi

pip install conan --upgrade
pip install conan_package_tools

conan user
