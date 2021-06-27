#!/usr/bin/env bash

wget https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/gh-zsh.sh  &> /dev/null
chmod +x gh-zsh.sh
./gh-zsh.sh 
rm -f gh-zsh.sh
