#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"

function instalar-vsftpd {
    sudo apt install -y vsftpd
}

function configurar-vsftpd {
    echo "Ativar o serviço do VSFTPd"
    sudo systemctl enable vsftpd.service

    echo -e "\nAdicionar usuário 'vsftp' para uso em acesso ao SFTP"
    sudo useradd vsftp

    echo -e "\nDefinir a senha informada para o usuário 'vsftp'"
    echo "vsftp:$1" | sudo chpasswd

    echo -e "\nCriar pasta 'ftp/backups' pertencente ao usuário/grupo 'vsftp' em HOME de usuário 'vsftp'"
    sudo mkdir /home/vsftp/ftp
    sudo chown nobody:nogroup /home/vsftp/ftp
    sudo chmod a-w /home/vsftp/ftp/
    sudo mkdir /home/vsftp/ftp/backups
    sudo chown vsftp:vsftp /home/vsftp/ftp/backups



    # NOVACONFIG="AllowUsers ti\nDenyUsers root esus"
    # CONFIGSSH="/etc/ssh/sshd_config"
    # COPIACONFIGSSH="${CONFIGSSH}.original"

    # echo -e "\nGerar cópia de arquivo de configuração de SSH($CONFIGSSH), adicionar permissão para usuário 'ti' e remover permissão de usuários 'root' e 'esus', se necessário"
    # # somente será gerado cópia e adicionado nova configuração se não foi ainda gerado o backup .original com config original de sshd_config
    # ! sudo test -f $COPIACONFIGSSH &&
    #     sudo cp -v $CONFIGSSH $COPIACONFIGSSH &&
    #     echo -e $NOVACONFIG | sudo tee -a $CONFIGSSH

    # echo -e "\nReiniciar serviço do SSH"
    # sudo systemctl restart sshd.service

    # echo -e "\nAdicionar excessão para SSH em UFW"
    # sudo ufw allow ssh
}

if [[ $# -eq 0 ]]; then
    echo "Informe uma senha para o usuário 'vsftp'" | log $0
    exit 1
fi

instalar-vsftpd | log $0
configurar-vsftpd $1 | log $0
