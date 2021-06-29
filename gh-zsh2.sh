#!/usr/bin/env bash

#--------------------------------------------------
# Shell Configurations
#--------------------------------------------------
OS="$(uname)"
if [[ "$OS" == "Linux" ]] || [[ "$OS" == "Darwin" ]] ; then
    echo
    if [[ "$OS" == "Linux" ]]; then
        echo "--> Please, type your Password:"
        sudo apt install zsh bat git -y &> /dev/null
        echo -e "\nInstalling zsh, bat, and git"
    fi
    if [[ "$OS" == "Darwin" ]]; then
        version_gt() {
        [[ "${1%.*}" -gt "${2%.*}" ]] || [[ "${1%.*}" -eq "${2%.*}" && "${1#*.}" -gt "${2#*.}" ]]
        }
        version_ge() {
        [[ "${1%.*}" -gt "${2%.*}" ]] || [[ "${1%.*}" -eq "${2%.*}" && "${1#*.}" -ge "${2#*.}" ]]
        }
        major_minor() {
        echo "${1%%.*}.$(x="${1#*.}"; echo "${x%%.*}")"
        }
        macos_version="$(major_minor "$(/usr/bin/sw_vers -productVersion)")"
        should_install_command_line_tools() {
        if version_gt "$macos_version" "10.13"; then
            ! [[ -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]
        else
            ! [[ -e "/Library/Developer/CommandLineTools/usr/bin/git" ]] ||
            ! [[ -e "/usr/include/iconv.h" ]]
        fi
        }
        if should_install_command_line_tools && version_ge "$macos_version" "10.13"; then
            echo "Xcode Command Line Tools not found. Installing..."
            echo "--> When prompted for the password, enter your Mac login password."
            shell_join() {
                local arg
                printf "%s" "$1"
                shift
                for arg in "$@"; do
                    printf " "
                    printf "%s" "${arg// /\ }"
                done
            }
            chomp() {
                printf "%s" "${1/"$'\n'"/}"
            }
            have_sudo_access() {
                local -a args
                if [[ -n "${SUDO_ASKPASS-}" ]]; then
                    args=("-A")
                elif [[ -n "${NONINTERACTIVE-}" ]]; then
                    args=("-n")
                fi
            }
            have_sudo_access() {
                local -a args
                if [[ -n "${SUDO_ASKPASS-}" ]]; then
                    args=("-A")
                elif [[ -n "${NONINTERACTIVE-}" ]]; then
                    args=("-n")
                fi

                if [[ -z "${HAVE_SUDO_ACCESS-}" ]]; then
                    if [[ -n "${args[*]-}" ]]; then
                    SUDO="/usr/bin/sudo ${args[*]}"
                    else
                    SUDO="/usr/bin/sudo"
                    fi
                    if [[ -n "${NONINTERACTIVE-}" ]]; then
                    ${SUDO} -l mkdir &>/dev/null
                    else
                    ${SUDO} -v && ${SUDO} -l mkdir &>/dev/null
                    fi
                    HAVE_SUDO_ACCESS="$?"
                fi

                if [[ -z "${HOMEBREW_ON_LINUX-}" ]] && [[ "$HAVE_SUDO_ACCESS" -ne 0 ]]; then
                    abort "Need sudo access on macOS (e.g. the user $USER needs to be an Administrator)!"
                fi

                return "$HAVE_SUDO_ACCESS"
            }
            execute() {
                if ! "$@"; then
                    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
                fi
            }
            execute_sudo() {
                local -a args=("$@")
                if have_sudo_access; then
                    if [[ -n "${SUDO_ASKPASS-}" ]]; then
                    args=("-A" "${args[@]}")
                    fi
                    execute "/usr/bin/sudo" "${args[@]}"
                else
                    execute "${args[@]}"
                fi
            }
            TOUCH="/usr/bin/touch"
            clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
            execute_sudo "$TOUCH" "$clt_placeholder"
            clt_label_command="/usr/sbin/softwareupdate -l |
                                grep -B 1 -E 'Command Line Tools' |
                                awk -F'*' '/^ *\\*/ {print \$2}' |
                                sed -e 's/^ *Label: //' -e 's/^ *//' |
                                sort -V |
                                tail -n1"
            clt_label="$(chomp "$(/bin/bash -c "$clt_label_command")")"

            if [[ -n "$clt_label" ]]; then
                execute_sudo "/usr/sbin/softwareupdate" "-i" "$clt_label"
                execute_sudo "/bin/rm" "-f" "$clt_placeholder"
                execute_sudo "/usr/bin/xcode-select" "--switch" "/Library/Developer/CommandLineTools"
            fi
        fi
        echo "Checking for homebrew installation"
    fi
    echo -e "\nShell Configurations"
    if [[ "$OS" == "Darwin" ]]; then
        chsh -s /bin/zsh &> /dev/null
    fi
    if [[ "$OS" == "Linux" ]]; then
        sudo usermod -s /usr/bin/zsh $(whoami) &> /dev/null
        sudo usermod -s /usr/bin/zsh root &> /dev/null
    fi
    if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d") &> /dev/null; then
        echo -e "\n--> Backing up the current .zshrc config to .zshrc-backup-date"
    fi
    (cd ~/ && curl -O https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/.zshrc) &> /dev/null
    echo "source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
    echo "source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" >> ~/.zshrc
    echo "source $HOME/.zsh/completion.zsh" >> ~/.zshrc
    echo "source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    echo "source $HOME/.zsh/history.zsh" >> ~/.zshrc
    echo "source $HOME/.zsh/key-bindings.zsh" >> ~/.zshrc
    if [[ "$OS" == "Linux" ]]; then
        sudo cp /home/"$(whoami)"/.zshrc /root/
    fi
    #--------------------------------------------------
    # Theme Installation
    #--------------------------------------------------
    echo -e "\nTheme Installation"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k &> /dev/null
    (cd ~/ && curl -O https://raw.githubusercontent.com/gustavohellwig/gh-zsh/main/.p10k.zsh) &> /dev/null
    if [[ "$OS" == "Linux" ]]; then
        sudo cp /home/"$(whoami)"/.p10k.zsh /root/
    fi
    #--------------------------------------------------
    # Plugins Installations
    #--------------------------------------------------
    echo -e "\nPlugins Installations"
    git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting &> /dev/null
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions &> /dev/null
    (cd ~/ && curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh) &> /dev/null
    (cd ~/ && curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh) &> /dev/null
    (cd ~/ && curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/key-bindings.zsh) &> /dev/null

    echo -e "\nInstallation Finished"
    echo -e "\n--> Reopen Terminal or run 'zsh' to start using it. \n"

    if [[ "$OS" == "Linux" ]]; then
        exec /usr/bin/zsh
    fi
    if [[ "$OS" == "Linux" ]]; then
        exec /bin/zsh
    fi
else
    echo "This script is only supported on macOS and Linux."
    exit 0
fi
