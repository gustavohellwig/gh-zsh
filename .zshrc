[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi
zmodload -i zsh/complist

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias less='less -R'
alias check-docker='sudo docker ps --no-trunc --format "table {{.Names}}\t{{.Image}}\t{{.Command}}\t{{.Status}}\t{{.Ports}}"'

if [[ "$(uname)" == "Linux" ]]; then
    alias bat='batcat --theme base16 -p'
    alias ls='ls -h --color=auto'
    alias la='ls -lah --color=auto'
    check-ports() {
      sudo netstat -plntu -A inet -A inet6 | awk '
        BEGIN {
            printf "%-8s %-25s %-8s %s\n", "Proto", "Local Addr", "PID", "Path";
            printf "%-8s %-25s %-8s %s\n", "-------", "------------", "---", "----";
        }
        NR>2 {
            proto=$1
            local_addr=$4
            pid_field=(proto=="tcp" || proto=="tcp6")?$7:$6

            if(!seen[$0]++ && local_addr !~ /^172/ && pid_field != "938/named") {
                pid = pid_field
                sub(/\/.*/, "", pid)

                path = ""
                if(pid ~ /^[0-9]+$/) {
                    cmd="readlink -f /proc/" pid "/exe 2>/dev/null"
                    if((cmd | getline path) <= 0) path="[path lookup failed]"
                    close(cmd)
                }

                # Extract port
                split(local_addr, a, ":")
                port = a[length(a)]
                ports[port+0] = sprintf("%-8s %-25s %-8s %s", proto, local_addr, pid, path)
            }
        }
        END {
            n = asorti(ports, sorted_ports, "@ind_num_asc")
            for(i=1; i<=n; i++) print ports[sorted_ports[i]]
        }'
    }
fi

# Exports
export TERM="xterm-256color"
export LANGUAGE="C.UTF-8"
export LANG="C.UTF-8"
export LC_ALL="C.UTF-8"
export LC_CTYPE="C.UTF-8"
export LC_MESSAGES="C.UTF-8"
