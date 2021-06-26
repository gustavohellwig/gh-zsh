# zsh-theme
A simple script to setup an awesome shell environment with:
* powerlevel10k theme (https://github.com/romkatv/powerlevel10k)
* zsh-completions (https://github.com/zsh-users/zsh-completions)
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
* zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
* history-substring-search (https://github.com/zsh-users/zsh-history-substring-search)
* k (https://github.com/supercrabtree/k)

Sets following useful aliases:
* l="ls -lah"         - just type "l" instead of "ls -lah"
* alias k="k -h"	  - show human readable filesizes, in kb, mb etc
* x="exit"

## Installation

``` bash
curl -fsSL https://raw.githubusercontent.com/gustavohellwig/zsh-theme/main/zsh-theme.sh | bash
```

## Notes
* If you are already using zsh, your zsh config will be backed up to .zshrc-backup-date
* If the text/icons look broken, make sure your terminal is using one of the Nerd fonts. I recommend "Merlo Nerd Font"
