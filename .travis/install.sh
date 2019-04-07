#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv
    brew install cmake || true

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi
    
    export LDFLAGS="-L/usr/local/opt/readline/lib"
    export CPPFLAGS="-I/usr/local/opt/readline/include"
    export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

    pyenv install -s 2.7.10
    pyenv virtualenv -f 2.7.10 conan
    pyenv rehash
    pyenv activate conan
fi

pip install conan --upgrade
pip install conan_package_tools

conan user
