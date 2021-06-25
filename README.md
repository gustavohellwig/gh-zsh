# zsh-theme
A simple script to setup an awesome shell environment. Fork from: https://github.com/jotyGill/quickz-sh
Quickly install and setup zsh and oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh) with
* powerlevel10k theme (https://github.com/romkatv/powerlevel10k)
* Nerd-Fonts (https://github.com/ryanoasis/nerd-fonts)
* zsh-completions (https://github.com/zsh-users/zsh-completions)
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
* zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
* history-substring-search (https://github.com/zsh-users/zsh-history-substring-search)
* k (https://github.com/supercrabtree/k)

Sets following useful aliases:
* l="ls -lah"         - just type "l" instead of "ls -lah"
* alias k="k -h"	  - show human readable filesizes, in kb, mb etc
* x="exit"
* https               - make httpie use https
* cheat - (https://github.com/chubin/cheat.sh)        - cheatsheets in the terminal

## Demo

Currently the command prompt looks like this (easily customize it in zshrc)
![prompt](https://user-images.githubusercontent.com/8462091/43674765-8bb13a76-9817-11e8-8b7b-16b8b1998408.png)
user :  directory  :  git stats : last command exit code : ip : todo tasks : free memory: load : time

<!-- Watch this to get an idea of what your Shell (well, life!) could be like!! -->

<!-- [![asciicast](https://asciinema.org/a/225226.svg)](https://asciinema.org/a/225226) -->


## Installation
Requirements:
* `git` to clone it.
* `python3` or `python` is required to run option '-c' which copies history from .bash_history

``` bash
git clone https://github.com/gustavohellwig/zsh-theme.git ~/.zsh-theme
cd .zsh-theme
./zsh-theme.sh
```

Change your terminals fonts to either "RobotoMono Nerd Font" or "Hack Nerd Font" or "DejaVu Sans Mono Nerd Fonts".
You can also manually install Nerd Fonts of your choice.

## Notes
* If you are already using zsh, your zsh config will be backed up to .zshrc-backup-date

* If the text/icons look broken, make sure your terminal is using one of the Nerd fonts. I recommend "RobotoMono Nerd Font"
