#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-sshd {
    sudo apt install -y openssh-server
}

function configurar-sshd {
    echo "Adicionar usuário 'ti' para uso em acesso remoto via SSH"
    sudo useradd --system --no-create-home ti

    NOVACONFIG="AllowUsers ti\nDenyUsers root esus"
    CONFIGSSH="/etc/ssh/sshd_config"
    COPIACONFIGSSH="${CONFIGSSH}.original"

    echo -e "\nGerar cópia de arquivo de configuração de SSH($CONFIGSSH), adicionar permissão para usuário 'ti' e remover permissão de usuários 'root' e 'esus'"
    ! sudo test -f $COPIACONFIGSSH &&
        sudo cp -v $CONFIGSSH $COPIACONFIGSSH &&
        echo -e $NOVACONFIG | sudo tee -a $CONFIGSSH

    echo -e "\nAdicionar excessão para SSH em UFW"
    sudo ufw allow ssh
}

instalar-sshd | log $0
configurar-sshd | log $0
