# Scripts para instalação e configuração de Servidor Linux para o e-SUS
## Scripts para instalação e configuração de Oh My ZSH, Ultimate Vimrc, SSH, VSFTP, e-SUS e outras ferramentas, testado em Ubuntu 20.04 ou superior

Este repositório contém scripts para a instalação de várias ferramentas para deixar operacional um servidor Linux(testado em Ubuntu) para o [e-SUS PEC](https://sisaps.saude.gov.br/esus/). A partir dos scripts é instalado e configurado outras funcionalidades, como o ZSH e o Oh My ZSH, o VIM e o Ultimate vimrc, SSH, VSFTP e e-SUS(PEC).

Para o SSH(porta 22), VSFTP(portas 20, 21 e 10000-11000) e e-SUS PEC(porta 8080), é adicionado uma excessão ao firewall(ufw) automaticamente na execução dos scripts.

Ao executar o script **'04-SSHd.sh'**, é criado o usuário **ti** e liberado somente a ele o acesso remoto. Esse é um usuário comum, SEM permissão de administrador. Para poder ter permissão de administrador, após acesso SSH com o usuário ti, deve-se logar como algum usuário sudoer.
Sintaxe: `04-SSHd.sh "senha usuário ti"`

O script **'05-VSFTPd.sh'** cria o usuário **vsftp**, usado na autenticação do servidor FTP. 
Sintaxe: `05-VSFTPd.sh "senha usuário vsftp"`

Os scripts geram um arquivo de log **scripts-servidor-esus.log** com os detalhes da execução, no diretório raiz dos scripts.

Scripts testados em Máquina virtual(VirtualBox) Ubuntu nas versões 20.04 e 22.04.


### Arquivos
```
README.md: Este arquivo de ajuda.
01-oh_my_zsh.sh: Instalação e configuração de ZSH e (Oh my ZSH)[https://ohmyz.sh/].
02-ultimate_vimrc.sh: Instalação e configuração de VIM e (Ultimate vimrc)[https://github.com/amix/vimrc].
03-ferramentas_diversas.sh: Instalação e configuração de VirtualBOX, Docker, Gparted, Smartmontools, lnav, htop, nmon, nmap, tree e outras ferramentas. Script também ativa o firewall do Ubuntu via UFW e adiciona o usuário ao grupo do docker.
04-SSHd.sh: Instalação e configuração do SSH. 
05-VSFTPd.sh: Instalação e configuração do VSFTP.
06-eSUS.sh: Instalação e configuração do (e-SUS)[https://sisaps.saude.gov.br/esus/].
07-backup_restore_db-esus.sh: Backup de banco de dados e restauração a partir de arquivo de backup(*.backup) do e-SUS.
log.sh: Script com função para gerar o log personalizados dos scripts.
obter_link_jar_eSUS.py: Script em Python(3) para obter o link do JAR do e-SUS PEC atualizado.
```


### Licença
**Licença MIT**, arquivo em anexo no repositório.


### Contato

Paulo Carvalho da Silva Junior - pauluscave@gmail.com
