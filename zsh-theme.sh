#!/bin/bash

#--------------------------------------------------
# Shell Configurations
#--------------------------------------------------
sudo apt install zsh bat wget git -y &> /dev/null
echo -e "\nShell Configurations\n"
sudo usermod -s /usr/bin/zsh $(whoami) &> /dev/null
sudo usermod -s /usr/bin/zsh root &> /dev/null
if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d") &> /dev/null; then
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi
wget https://raw.githubusercontent.com/gustavohellwig/zsh-theme/main/.zshrc -P ~/ &> /dev/null
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
echo -e "\nTheme Installation"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k &> /dev/null
wget https://raw.githubusercontent.com/gustavohellwig/zsh-theme/main/.p10k.zsh -P ~/ &> /dev/null
sudo cp /home/"$(whoami)"/.p10k.zsh /root/
#--------------------------------------------------
# Plugins Installations
#--------------------------------------------------
echo -e "\nPlugins Installations"
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting &> /dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions &> /dev/null
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh -P ~/.zsh/ &> /dev/null
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh -P ~/.zsh/ &> /dev/null
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/key-bindings.zsh -P ~/.zsh/ &> /dev/null

exec zsh -l
