#!/usr/bin/env bash
set -e

OS="$(uname)"

#===========================================================
# Create required folders
#===========================================================
mkdir -p ~/.zsh
mkdir -p ~/.zsh/plugins

#===========================================================
# Helpers
#===========================================================
msg() { echo -e "\n→ $1"; }
err() { echo "ERROR: $1" >&2; exit 1; }

backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cp "$file" "${file}.backup-$(date +%F)" &> /dev/null
        msg "Backup created: ${file}.backup-$(date +%F)"
    fi
}

copy_to_root() {
    if [[ "$OS" == "Linux" ]]; then
        sudo cp -r ~/.zsh /root/
        sudo cp ~/.zshrc /root/ 2>/dev/null || true
        sudo cp ~/.p10k.zsh /root/ 2>/dev/null || true
    fi
}

#===========================================================
# macOS – Command Line Tools Install
#===========================================================
install_clt_macos() {
    msg "Checking Xcode Command Line Tools…"

    if xcode-select -p &>/dev/null; then
        msg "Command Line Tools already installed"
        return
    fi

    msg "Installing macOS Command Line Tools…"

    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    PROD=$(
        softwareupdate -l \
        | grep -B 1 -E "Command Line Tools" \
        | awk -F"*" '/^ *\*/ {print $2}' \
        | sed 's/^ *Label: //' \
        | sort -V \
        | tail -n1
    )

    softwareupdate -i "$PROD" --verbose
    rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    xcode-select --switch /Library/Developer/CommandLineTools
}

#===========================================================
# OS-specific Setup
#===========================================================
if [[ "$OS" == "Linux" ]]; then
    msg "Installing zsh, bat, and git"
    sudo apt update &> /dev/null
    sudo apt install -y zsh bat git curl &> /dev/null
fi

if [[ "$OS" == "Darwin" ]]; then
    install_clt_macos
fi

#===========================================================
# Change Shell
#===========================================================
msg "Setting ZSH as default shell"
if [[ "$OS" == "Darwin" ]]; then
    chsh -s /bin/zsh &> /dev/null
else
    sudo chsh -s /usr/bin/zsh "$(whoami)" &> /dev/null
    sudo chsh -s /usr/bin/zsh root &> /dev/null
fi

#===========================================================
# Backup old zshrc + download new
#===========================================================
backup_file ~/.zshrc
msg "Downloading new .zshrc"
curl -fsSL -o ~/.zshrc \
    https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/.zshrc

#===========================================================
# Install Theme
#===========================================================
msg "Installing Powerlevel10k theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k &> /dev/null

curl -fsSL -o ~/.p10k.zsh \
    https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/.p10k.zsh

#===========================================================
# Install Plugins
#===========================================================
msg "Installing Plugins"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting &> /dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions &> /dev/null

curl -fsSL -o ~/.zsh/completion.zsh \
    https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh

curl -fsSL -o ~/.zsh/history.zsh \
    https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh

curl -fsSL -o ~/.zsh/key-bindings.zsh \
    https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/key-bindings.zsh

#===========================================================
# Update .zshrc sources
#===========================================================
cat << 'EOF' >> ~/.zshrc

# Custom additions
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/key-bindings.zsh

EOF

#===========================================================
# Copy to root (Linux only)
#===========================================================
copy_to_root

#===========================================================
# Finish
#===========================================================
msg "Installation Finished!"
msg "→ Reopen terminal if theme doesn't load automatically."

# Execute ZSH
exec zsh -i
