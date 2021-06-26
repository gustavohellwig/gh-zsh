# zsh-theme
A simple script to setup an awesome shell environment with:
* powerlevel10k theme (https://github.com/romkatv/powerlevel10k)
* zsh-completions (https://github.com/zsh-users/zsh-completions)
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
* zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
* history-substring-search (https://github.com/zsh-users/zsh-history-substring-search)
* k (https://github.com/supercrabtree/k)

Sets following useful aliases:
* ..='cd ..'
* ...='cd ../..'
* ....='cd ../../..'
* grep='grep --color=auto'                # colorize `grep` output
* less='less -R'
* rm='rm -i'                              # confirm removal
* cp='cp -i'                              # confirm copy
* mv='mv -i'                              # confirm move
* bat='batcat --theme base16 -p'
* ls='ls -h --color=auto'
* la='ls -la --color=auto'

## Installation

``` bash
curl -fsSL https://raw.githubusercontent.com/gustavohellwig/zsh-theme/main/zsh-theme.sh | bash
```

## Notes
* If you are already using zsh, your zsh config will be backed up to .zshrc-backup-date
* If the text/icons look broken, make sure your terminal is using one of the Nerd fonts. I recommend "Merlo Nerd Font"
