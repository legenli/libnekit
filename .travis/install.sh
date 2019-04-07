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
    
    wget https://www.openssl.org/source/openssl-1.1.0j.tar.gz
    tar -xvzf openssl-1.1.0j.tar.gz
    ./openssl-1.1.0j/config --prefix=/usr/local/openssl11 --openssldir=/usr/local/openssl11
    make
    make install
    CONFIGURE_OPTS="--with-openssl=/usr/local/openssl11" \
    LDFLAGS="-L/usr/local/openssl11/lib" \
    LD_RUN_PATH="/usr/local/openssl11/lib" \
    CPPFLAGS="-I/usr/local/openssl11/include" \
    CFLAGS="-I/usr/local/openssl11/include" \
    pyenv install -s 2.7.10
    pyenv virtualenv -f 2.7.10 conan
    pyenv rehash
    pyenv activate conan
fi

pip install conan --upgrade
pip install conan_package_tools

conan user
