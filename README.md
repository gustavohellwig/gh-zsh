![image](https://github.com/gustavohellwig/gh-zsh/assets/7680647/e09ed8ae-1090-4edd-85fe-e4e6ee2c32d9)# gh-zsh
A simple script to set an awesome shell environment for Ubuntu and MacOS, with:
* powerlevel10k theme (https://github.com/romkatv/powerlevel10k)
* zsh-completions (https://github.com/zsh-users/zsh-completions)
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
* fast-syntax-highlighting (https://github.com/zdharma-continuum/fast-syntax-highlighting/
* completion (https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh)
* history (https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh)
* key-bindings (https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/key-bindings.zsh)

Sets the following useful aliases:
* ..='cd ..'
* ...='cd ../..'
* ....='cd ../../..'
* grep='grep --color=auto'

For Linux
* bat='batcat --theme base16 -p'
* ls='ls -h --color=auto'
* la='ls -la --color=auto'

## Demo

Currently, the command prompt looks like this:
![ZSH-Prompt](https://github.com/gustavohellwig/gh-zsh/blob/2e0ac65f20691f1f26e17145013e4a1260a0128e/gh-zsh-example.png)
## Installation

``` bash
curl -fsSL https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/gh-zsh.sh | bash
```

## Notes
* •	If you already use zsh, your zsh config will be backed up to .zshrc-backup-date.
* •	If the text/icons look broken, ensure your terminal uses one of the Nerd fonts.
* Tested on:
  * Ubuntu 20.04, 22.04
  * MacOS 10.14, 11.3, 14.3.1
