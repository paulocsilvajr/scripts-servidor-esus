#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-ferramentas {
    apty="sudo apt install -y"
    $apty lnav htop nmon nmap tree tuptime
    $apty virtualbox virtualbox-qt
    $apty docker docker-compose docker-doc
    $apty smartmontools gparted
}

function ativar-ufw() {
    sudo ufw enable
}

instalar-ferramentas | log $0
ativar-ufw | log $0
