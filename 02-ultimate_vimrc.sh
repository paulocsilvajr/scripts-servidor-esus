#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-requisitos-vim {
    sudo apt install git vim
}

function instalar-ultimate_vimrc {
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
}

instalar-requisitos-vim | log $0
instalar-ultimate_vimrc | log $0
