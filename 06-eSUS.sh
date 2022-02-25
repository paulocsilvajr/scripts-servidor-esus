#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-java {
    sudo apt install -y openjdk-8-jdk
}

function instalar-e-configura-esus {
    jar="$BASE/${1##*/}"
    sudo java -jar $jar -console -continue

    sudo ufw allow 8080/tcp
}

if [[ $# -eq 0 ]]; then
    echo "Informe o link do arquivo JAR da instalação do e-SUS" | log $0
    exit 1
fi

wget -c $1 -P $BASE | exit 1

instalar-java | log $0
instalar-e-configura-esus $1 | log $0
