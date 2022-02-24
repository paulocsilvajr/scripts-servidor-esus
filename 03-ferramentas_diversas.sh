#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-ferramentas {
    apty="sudo apt install -y"
    $apty lnav htop nmon nmap
    $apty virtualbox virtualbox-qt
    $apty docker docker-compose docker-doc
}

instalar-ferramentas | log $0
