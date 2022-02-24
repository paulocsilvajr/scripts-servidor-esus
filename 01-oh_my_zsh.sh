#!/usr/bin/env bash

sudo apt install zsh curl wget

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
omz theme set bureau
