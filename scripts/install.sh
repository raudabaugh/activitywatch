#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#git submodule update --init --recursive

function fatal_error() {
    echo "Something went wrong, aborting"
    exit 1
}

function install_package() {
    echo "Installing $(pwd)"
    if [[ $NOROOT_INSTALL ]]; then
        python3 setup.py develop || fatal_error
    else
        sudo python3 setup.py develop || fatal_error
    fi
}

if [[ $1 == '--noroot' ]]; then
    NOROOT_INSTALL=true
    echo "Installing without root"
fi

# TODO: Detect folders, don't require a definition of them
FOLDERS="aw-core aw-client aw-server aw-watcher-afk aw-watcher-window aw-qt"
cd "$DIR/.."
for FOLDER in $FOLDERS; do
    cd $FOLDER
    install_package
    cd ..
done