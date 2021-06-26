# zsh-theme
A simple script to setup an awesome shell environment with:
* powerlevel10k theme (https://github.com/romkatv/powerlevel10k)
* zsh-completions (https://github.com/zsh-users/zsh-completions)
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
* fast-syntax-highlighting (https://github.com/zdharma/fast-syntax-highlighting/
* completion (https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh)
* history (https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh)
* key-bindings (https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/key-bindings.zsh)

Sets following useful aliases:
* ..='cd ..'
* ...='cd ../..'
* ....='cd ../../..'
* grep='grep --color=auto'
* less='less -R'
* rm='rm -i'
* cp='cp -i'
* mv='mv -i'
* bat='batcat --theme base16 -p'
* ls='ls -h --color=auto'
* la='ls -la --color=auto'

## Demo

Currently the command prompt looks like this:
![ZSH-Prompt](https://github.com/gustavohellwig/zsh-theme/blob/main/zsh-example.png?raw=true)
## Installation

``` bash
curl -fsSL https://raw.githubusercontent.com/gustavohellwig/zsh-theme/main/zsh-theme.sh | bash
```

## Notes
* If you are already using zsh, your zsh config will be backed up to .zshrc-backup-date
* If the text/icons look broken, make sure your terminal is using one of the Nerd fonts. I recommend "Merlo Nerd Font"
