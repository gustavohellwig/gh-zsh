#===========================================================
# Powerlevel10k
#===========================================================

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#===========================================================
# Completion
#===========================================================
fpath+=($HOME/.zsh/zsh-completions/src)
autoload -Uz compinit

if [[ ! -f ~/.zcompdump ]]; then
    compinit -i
else
    compinit -C -i
fi

zmodload -i zsh/complist

#===========================================================
# Environment
#===========================================================

export TERM="xterm-256color"
export LANGUAGE="C.UTF-8"
export LANG="C.UTF-8"
export LC_ALL="C.UTF-8"
export LC_CTYPE="C.UTF-8"
export LC_MESSAGES="C.UTF-8"
export HOMEBREW_NO_ENV_HINTS=1

#===========================================================
# Sources
#===========================================================

source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/key-bindings.zsh

#===========================================================
# Common Aliases
#===========================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias p='pwd'
alias c='clear'

if command -v eza >/dev/null 2>&1; then
    alias ls='eza'
    alias ll='eza -lah'
    alias la='eza -lah'
    alias l='eza -lah --git'
    alias tree='eza --tree'
else
    alias ll='ls -lah'
    alias l='ls -CF'
    alias ls='ls -h --color=auto'
    alias la='ls -lah --color=auto'
fi

alias df='df -h'
alias psaux='ps aux | grep -i'
alias digs='dig +short'

alias myip='curl -4 -s https://icanhazip.com'
alias myip6='curl -6 -s https://icanhazip.com'

alias less='less -R'

#===========================================================
# Docker
#===========================================================

alias dps='docker ps'
alias dimgs='docker images'
alias dlog='docker logs -f'
alias dexec='docker exec -it'

check-docker() {
    sudo docker ps \
        --no-trunc \
        --format "table {{.Names}}\t{{.Image}}\t{{.Command}}\t{{.Status}}\t{{.Ports}}"
}

#===========================================================
# Linux
#===========================================================

if [[ "$(uname)" == "Linux" ]]; then

    alias grep='grep --color=auto'
    alias free='free -h'
    alias topcpu='ps aux --sort=-%cpu | head'
    alias topmem='ps aux --sort=-%mem | head'

    if command -v batcat >/dev/null 2>&1; then
        alias bat='batcat --theme base16 -p'
    fi

    check-ports() {
        sudo netstat -plntu -A inet | gawk '
        BEGIN {
            printf "%-8s %-25s %-8s %-20s %-20s %s\n","Proto","Local Addr","PID","Process","Service","Path";
            printf "%-8s %-25s %-8s %-20s %-20s %s\n","-------","------------","---","-------","-------","----";
        }
        NR>2 {
            proto=$1
            local_addr=$4
            pid_field=(proto=="tcp") ? $7 : $6

            if(!seen[$0]++ && local_addr !~ /^172/) {

                pid = pid_field
                sub(/\/.*/, "", pid)

                proc = pid_field
                sub(/^[0-9]+\//, "", proc)

                gsub(/:/, "", proc)
                gsub(/"/, "", proc)

                split(local_addr, a, ":")
                port = a[length(a)]

                path = ""
                service = proc

                if(pid ~ /^[0-9]+$/) {

                    cmd="readlink -f /proc/" pid "/exe 2>/dev/null"
                    if((cmd | getline path) <= 0)
                        path="[path lookup failed]"
                    close(cmd)

                    cmd="sudo ss -tulpnH 2>/dev/null | grep :" port

                    while((cmd | getline line) > 0) {

                        if(match(line, /\("[^"]+"/)) {

                            service=substr(line,RSTART+2,RLENGTH-2)

                            gsub(/"/, "", service)
                            gsub(/:/, "", service)

                            if(service != proc)
                                break
                        }
                    }

                    close(cmd)
                }

                ports[port+0] = sprintf("%-8s %-25s %-8s %-20s %-20s %s",
                                        proto,
                                        local_addr,
                                        pid,
                                        proc,
                                        service,
                                        path)
            }
        }
        END {
            n = asorti(ports, sorted_ports, "@ind_num_asc")

            for(i=1; i<=n; i++)
                print ports[sorted_ports[i]]
        }'
    }

fi

#===========================================================
# macOS
#===========================================================

if [[ "$(uname)" == "Darwin" ]]; then

    alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

    alias fixql='killall quicklookd && killall QuickLookUIService && killall Finder'

    alias chrome='open -a "Google Chrome" --args --incognito'

    alias brave='open -a "Brave Browser" --args --incognito'

    alias firefox='open -a Firefox --args -private-window'

    [[ -d "$HOME/_Tools/bin/gam7" ]] && \
        export PATH="$HOME/_Tools/bin/gam7:$PATH"

    [[ -d "$HOME/_Tools/bin/gyb" ]] && \
        export PATH="$HOME/_Tools/bin/gyb:$PATH"

fi
