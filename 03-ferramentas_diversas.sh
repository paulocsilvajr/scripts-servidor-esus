#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-ferramentas {
    apty="sudo apt install -y"
    $apty lnav htop nmon nmap tree tuptime tmux iftop
    $apty virtualbox virtualbox-qt
    $apty docker docker-compose docker-doc
    $apty smartmontools gparted ncdu iotop
    $apty preload
    sudo usermod -aG docker $USER
}

function permissao-docker {
    sudo usermod -aG docker $USER
}

function ativar-ufw() {
    sudo ufw enable
}

instalar-ferramentas | log $0
ativar-ufw | log $0
permissao-docker | log $0

