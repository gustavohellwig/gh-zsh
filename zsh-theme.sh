#!/bin/bash

# if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
#     echo -e "ZSH and Git are already installed\n"
# else
#     if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
#         echo -e "zsh wget and git Installed\n"
#     else
#         echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
#     fi
# fi

# if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
#     echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
# fi

# echo -e "Installing oh-my-zsh\n"
# if [ -d ~/.oh-my-zsh ]; then
#     echo -e "oh-my-zsh is already installed\n"
# else
#     git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
# fi

# cp -f .zshrc ~/

# mkdir -p ~/.quickzsh       # external plugins, things, will be instlled in here

# if [ -d ~/.oh-my-zsh/plugins/zsh-autosuggestions ]; then
#     cd ~/.oh-my-zsh/plugins/zsh-autosuggestions && git pull
# else
#     git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
# fi

# if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
#     cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
# else
#     git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# fi

# if [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
#     cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
# else
#     git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
# fi

# if [ -d ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
#     cd ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
# else
#     git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
# fi

# # INSTALL FONTS

# echo -e "Installing Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

# # get -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
# wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
# # wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/

# fc-cache -fv ~/.fonts

# if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
#     cd ~/.oh-my-zsh/custom/themes/powerlevel10k && git pull
# else
#     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
# fi

# # if [ -d ~/.quickzsh/fzf ]; then
# #     cd ~/.quickzsh/fzf && git pull
# #     ~/.quickzsh/fzf/install --all --key-bindings --completion --no-update-rc --64
# # else
# #     git clone --depth 1 https://github.com/junegunn/fzf.git ~/.quickzsh/fzf
# #     ~/.quickzsh/fzf/install --all --key-bindings --completion --no-update-rc --64
# # fi

# if [ -d ~/.oh-my-zsh/custom/plugins/k ]; then
#     cd ~/.oh-my-zsh/custom/plugins/k && git pull
# else
#     git clone --depth 1 https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
# fi

# # if [ -d ~/.quickzsh/marker ]; then
# #     cd ~/.quickzsh/marker && git pull
# # else
# #     git clone --depth 1 https://github.com/pindexis/marker ~/.quickzsh/marker
# # fi

# # if ~/.quickzsh/marker/install.py; then
# #     echo -e "Installed Marker\n"
# # else
# #     echo -e "Marker Installation Had Issues\n"
# # fi

# # if git clone --depth 1 https://github.com/todotxt/todo.txt-cli.git ~/.quickzsh/todo; then :
# # else
# #     cd ~/.quickzsh/todo && git fetch --all && git reset --hard origin/master
# # fi
# # mkdir ~/.quickzsh/todo/bin ; cp -f ~/.quickzsh/todo/todo.sh ~/.quickzsh/todo/bin/todo.sh # cp todo.sh to ./bin so only it is included in $PATH
# # #touch ~/.todo/config     # needs it, otherwise spits error , yeah a bug in todo
# # ln -s ~/.quickzsh/todo ~/.todo
# # if [ ! -L ~/.quickzsh/todo/bin/todo.sh ]; then
# #     echo -e "Installing todo.sh in ~/.quickzsh/todo\n"
# #     mkdir -p ~/.quickzsh/todo/bin
# #     wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.11.0/todo.txt_cli-2.11.0.tar.gz" -P ~/.quickzsh/
# #     tar xvf ~/.quickzsh/todo.txt_cli-2.11.0.tar.gz -C ~/.quickzsh/todo --strip 1 && rm ~/.quickzsh/todo.txt_cli-2.11.0.tar.gz
# #     ln -s ~/.quickzsh/todo/todo.sh ~/.quickzsh/todo/bin/todo.sh     # so only .../bin is included in $PATH
# #     ln -s ~/.quickzsh/todo/todo.cfg ~/.todo.cfg     # it expects it there or ~/todo.cfg or ~/.todo/config
# # else
# #     echo -e "todo.sh is already instlled in ~/.quickzsh/todo/bin/\n"
# # fi

# echo -e "\nCopying bash_history to zsh_history\n"
# if command -v python &>/dev/null; then
#     wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
#     cat ~/.bash_history | python bash-to-zsh-hist.py >> ~/.zsh_history
# else
#     if command -v python3 &>/dev/null; then
#         wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
#         cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history
#     else
#         echo "Python is not installed, can't copy bash_history to zsh_history\n"
#     fi
# fi

# # source ~/.zshrc
# echo -e "\nSudo access is needed to change default shell\n"

# if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
#     echo -e "Installation Successful, exit terminal and enter a new session"
# else
#     echo -e "Something is wrong"
# fi
# exit

#--------------------------------------------------
# Shell Configurations
#--------------------------------------------------
# echo -e "\nShell Configurations\n"
sudo apt install zsh bat -y
sudo usermod -s /usr/bin/zsh $(whoami)
sudo usermod -s /usr/bin/zsh root
wget https://raw.githubusercontent.com/gustavohellwig/zsh-theme/main/.zshrc -P ~/
echo "source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
echo "source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" >> ~/.zshrc
echo "source $HOME/.zsh/completion.zsh" >> ~/.zshrc
echo "source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo "source $HOME/.zsh/history.zsh" >> ~/.zshrc
echo "source $HOME/.zsh/key-bindings.zsh" >> ~/.zshrc
sudo cp /home/"$(whoami)"/.zshrc /root/
#--------------------------------------------------
# Theme Installation
#--------------------------------------------------
# echo -e "\nTheme Installation\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
wget https://raw.githubusercontent.com/gustavohellwig/zsh-theme/main/.p10k.zsh -P ~/
sudo cp /home/"$(whoami)"/.p10k.zsh /root/
#--------------------------------------------------
# Plugins Installations
#--------------------------------------------------
# echo -e "\nPlugins Installations\n"
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh -P ~/.zsh/
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh -P ~/.zsh/
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/key-bindings.zsh -P ~/.zsh/

