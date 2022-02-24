#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-ferramentas {
    sudo apt install lnav htop nmon nmap
    sudo apt install virtualbox virtualbox-qt
}

instalar-ferramentas | log $0
