#!/usr/bin/env bash

BASE=$(dirname $0)
source "$BASE/log.sh"
BASECERT="/etc/cert"
CERT="$BASECERT/vsftpd.pem"

function instalar-vsftpd {
    sudo apt install -y vsftpd
}

function configurar-vsftpd {
    echo "Ativar o serviço do VSFTPd"
    sudo systemctl enable vsftpd.service

    echo -e "\nAdicionar usuário 'vsftp' para uso em acesso ao SFTP"
    sudo useradd -m vsftp

    echo -e "\nDefinir a senha informada para o usuário 'vsftp'"
    echo "vsftp:$1" | sudo chpasswd

    echo -e "\nCriar pasta 'ftp/backups' pertencente ao usuário/grupo 'vsftp' em HOME de usuário 'vsftp'"
    sudo mkdir /home/vsftp/ftp
    sudo chown nobody:nogroup /home/vsftp/ftp
    sudo chmod a-w /home/vsftp/ftp/
    sudo mkdir /home/vsftp/ftp/backups
    sudo chown vsftp:vsftp /home/vsftp/ftp/backups

    PRIVATEKEY=$CERT

    NOVACONFIG="write_enable=YES\nlocal_umask=022\nftpd_banner=Bem Vindo ao Servidor FTP\nchroot_local_user=YES\nrsa_cert_file=$CERT\nrsa_private_key_file=$PRIVATEKEY\nssl_enable=YES\nallow_anon_ssl=NO\nforce_local_data_ssl=YES\nforce_local_logins_ssl=YES\nssl_tlsv1=YES\nssl_sslv2=NO\nssl_sslv3=NO\nrequire_ssl_reuse=NO\nssl_ciphers=HIGH\npasv_enable=Yes\npasv_min_port=10000\npasv_max_port=11000\nuser_sub_token=vsftp\nlocal_root=/home/vsftp/ftp\nuserlist_enable=YES\nuserlist_file=/etc/vsftpd.userlist\nuserlist_deny=NO"
    # Caso ocorra o erro "GnuTLS erro... unexpected TLS packet was received... ECONNABORTED..." ao tentar acessar via algum cliente FTP(Filezilla), deve ser adicionado em "/etc/vsftpd.conf" a seguinte linha(fim do arquivo): allow_writeable_chroot=YES

    # inserido escape para / para funcionar corretamente a substituição via sed
    CONFIGPARAREMOVER1="rsa_cert_file=\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem"
    CONFIGPARAREMOVER2="rsa_private_key_file=\/etc\/ssl\/private\/ssl-cert-snakeoil.key"
    CONFIGPARAREMOVER3="ssl_enable=NO"

    CONFIGVSFTP="/etc/vsftpd.conf"
    COPIACONFIGVSFTP="${CONFIGVSFTP}.original"

    echo -e "\nGerar cópia de arquivo de configuração de VSFTP($CONFIGVSFTP) e definir novas configurações"
    ! sudo test -f $COPIACONFIGVSFTP &&
        sudo cp -v $CONFIGVSFTP $COPIACONFIGVSFTP &&
        echo -e $NOVACONFIG | sudo tee -a $CONFIGVSFTP

    # remover algumas configurações
    sudo sed -i "s/$CONFIGPARAREMOVER1/#$CONFIGPARAREMOVER1/" $CONFIGVSFTP
    sudo sed -i "s/$CONFIGPARAREMOVER2/#$CONFIGPARAREMOVER2/" $CONFIGVSFTP
    sudo sed -i "s/$CONFIGPARAREMOVER3/#$CONFIGPARAREMOVER2/" $CONFIGVSFTP

    # criar arquivo de usuários autorizados
    sudo touch /etc/vsftpd.userlist
    echo "vsftp" | sudo tee /etc/vsftpd.userlist

    echo -e "\nReiniciar serviço do VSFTP"
    sudo systemctl restart vsftpd.service

    echo -e "\nAdicionar excessão para VSFTP em UFW"
    sudo ufw allow 20/tcp
    sudo ufw allow 21/tcp
    sudo ufw allow 10000:11000/tcp
}

if [[ $# -eq 0 ]]; then
    echo "Informe como parâmetro uma senha para o usuário 'vsftp'" | log $0
    exit 1
fi

echo "Gerar certificado para o VSFTP" | log $0
sudo mkdir $BASECERT | log $0
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $CERT -out $CERT

instalar-vsftpd | log $0
configurar-vsftpd $1 | log $0
