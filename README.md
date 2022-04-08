# Scripts para instalação e configuração de Servidor Linux para o e-SUS
## Scripts para instalação e configuração de Oh My ZSH, Ultimate Vimrc, SSH, VSFTP, e-SUS e outras ferramentas, testado em Ubuntu 20.04 ou superior

Este repositório contém scripts para a instalação de várias ferramentas para deixar operacional um servidor Linux(testado em Ubuntu) para o [e-SUS PEC](https://sisaps.saude.gov.br/esus/). A partir dos scripts é instalado e configurado outras funcionalidades, como o ZSH e o Oh My ZSH, o VIM e o Ultimate vimrc, SSH, VSFTP e e-SUS(PEC).

Para o SSH(porta 22), VSFTP(portas 20, 21 e 10000-11000) e e-SUS PEC(porta 8080), é adicionado uma excessão ao firewall(ufw) automaticamente na execução dos scripts.

Ao executar o script **'04-SSHd.sh'**, é criado o usuário **ti** e liberado somente a ele o acesso remoto. Esse é um usuário comum, SEM permissão de administrador. Para poder ter permissão de administrador, após acesso SSH com o usuário ti, deve-se logar como algum usuário sudoer.
Sintaxe: `04-SSHd.sh "senha usuário ti"`

O script **'05-VSFTPd.sh'** cria o usuário **vsftp**, usado na autenticação do servidor FTP. 
Sintaxe: `05-VSFTPd.sh "senha usuário vsftp"`

Os scripts geram um arquivo de log **log.txt** com os detalhes da execução, no diretório raiz dos scripts.


### Arquivos
```
README.md: Este arquivo de ajuda.
01-oh_my_zsh.sh: Instalação e configuração de ZSH e (Oh my ZSH)[https://ohmyz.sh/].
02-ultimate_vimrc.sh: Instalação e configuração de VIM e (Ultimate vimrc)[https://github.com/amix/vimrc].
03-ferramentas_diversas.sh: Instalação e configuração de VirtualBOX, Docker, Gparted, Smartmontools, lnav, htop, nmon, nmap e tree. É ativado o firewall do Ubuntu via UFW.
04-SSHd.sh: Instalação e configuração do SSH. 
05-VSFTPd.sh: Instalação e configuração do VSFTP.
06-eSUS.sh: Instalação e configuração do (e-SUS)[https://sisaps.saude.gov.br/esus/].
```


### Licença
**Licença MIT**, arquivo em anexo no repositório.


### Contato

Paulo Carvalho da Silva Junior - pauluscave@gmail.com
