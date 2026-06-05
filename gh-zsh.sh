#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "ERROR: Failed on line $LINENO"; exit 1' ERR

OS="$(uname)"

msg() { echo -e "\n→ $1"; }
err() { echo "ERROR: $1" >&2; exit 1; }

backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup="${file}.backup-$(date +%F-%H%M%S)"
        cp "$file" "$backup"
        msg "Backup created: $backup"
    fi
}

download_file() {
    local url="$1"
    local dest="$2"
    curl -fsSL "$url" -o "$dest" || err "Failed downloading $url"
}

git_clone_or_update() {
    local repo="$1"
    local target="$2"

    if [[ -d "$target/.git" ]]; then
        msg "Updating $(basename "$target")"
        git -C "$target" pull --ff-only
    else
        msg "Installing $(basename "$target")"
        git clone --depth=1 "$repo" "$target"
    fi
}

copy_to_root() {
    [[ "$OS" != "Linux" ]] && return

    msg "Copying configuration to root"

    sudo mkdir -p /root/.zsh
    sudo cp -a "$HOME/.zsh/." /root/.zsh/ 2>/dev/null || true
    sudo cp "$HOME/.zshrc" /root/ 2>/dev/null || true
    sudo cp "$HOME/.p10k.zsh" /root/ 2>/dev/null || true
}

mkdir -p "$HOME/.zsh"

install_clt_macos() {
    msg "Checking Xcode Command Line Tools"

    if xcode-select -p &>/dev/null; then
        msg "Command Line Tools already installed"
        return
    fi

    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

    PROD=$(
        softwareupdate -l |
        grep -B 1 -E "Command Line Tools" |
        awk -F"*" '/^\*/ {print $2}' |
        sed 's/^ *Label: //' |
        sort -V |
        tail -n1
    )

    softwareupdate -i "$PROD" --verbose
    rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    xcode-select --switch /Library/Developer/CommandLineTools
}

if [[ "$OS" == "Linux" ]]; then
    msg "Installing dependencies"

    sudo apt update
    sudo apt install -y zsh git curl

    if apt-cache show bat >/dev/null 2>&1; then
        sudo apt install -y bat
    elif apt-cache show batcat >/dev/null 2>&1; then
        sudo apt install -y batcat
    fi

    if command -v batcat >/dev/null 2>&1; then
        sudo ln -sf "$(command -v batcat)" /usr/local/bin/bat
    fi
fi

if [[ "$OS" == "Darwin" ]]; then
    install_clt_macos
fi

ZSH_PATH="$(command -v zsh)"
[[ -x "$ZSH_PATH" ]] || err "zsh not found"

msg "Setting ZSH as default shell"

if [[ "$SHELL" != "$ZSH_PATH" ]]; then
    chsh -s "$ZSH_PATH"
fi

if [[ "$OS" == "Linux" ]]; then
    sudo chsh -s "$ZSH_PATH" root || true
fi

backup_file "$HOME/.zshrc"

msg "Downloading configuration"

download_file \
    "https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/.zshrc" \
    "$HOME/.zshrc"

download_file \
    "https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/.p10k.zsh" \
    "$HOME/.p10k.zsh"

git_clone_or_update \
    "https://github.com/romkatv/powerlevel10k.git" \
    "$HOME/.zsh/powerlevel10k"

git_clone_or_update \
    "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" \
    "$HOME/.zsh/fast-syntax-highlighting"

git_clone_or_update \
    "https://github.com/zsh-users/zsh-autosuggestions.git" \
    "$HOME/.zsh/zsh-autosuggestions"

download_file \
    "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/completion.zsh" \
    "$HOME/.zsh/completion.zsh"

download_file \
    "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/history.zsh" \
    "$HOME/.zsh/history.zsh"

download_file \
    "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/key-bindings.zsh" \
    "$HOME/.zsh/key-bindings.zsh"

copy_to_root

msg "Installation Finished!"
msg "Restart your terminal or run:"
echo
echo "exec zsh -l"
echo

if [[ -t 1 ]]; then
    exec zsh -l
fi
