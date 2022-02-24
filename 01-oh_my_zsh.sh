#!/usr/bin/env bash

function instalar-requisitos-zsh {
    sudo apt install zsh curl wget python3-pygments chroma
}

function instalar-oh-my-zsh {
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Para listar temas:"
    echo -e "omz theme list\n"
    echo "Para definir um tema(bureau):"
    echo -e "omz theme set bureau\n"
    echo "Para ativar plugins(git asdf python pip colored-man-pages colorize docker docker-compose ufw):"
    echo -e "omz plugin enable git asdf python pip colored-man-pages colorize docker docker-compose ufw\n"
}

instalar-requisitos-zsh
instalar-oh-my-zsh
