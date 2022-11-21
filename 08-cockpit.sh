#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-cockpit {
    apty="sudo apt install -y"
    $apty cockpit cockpit-networkmanager cockpit-storaged cockpit-system

    sudo ufw allow 9090/tcp
}

instalar-cockpit | log $0
