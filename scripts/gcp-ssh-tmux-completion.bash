#!/bin/bash

# Bash completion for gcp-ssh-tmux script
# 
# To enable completion, source this file in your shell:
#   source /Users/benwh/bin/gcp-ssh-tmux-completion.bash
#
# Or add it to your ~/.bashrc or ~/.bash_profile:
#   echo "source /Users/benwh/bin/gcp-ssh-tmux-completion.bash" >> ~/.bashrc

_gcp_ssh_tmux_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    case ${COMP_CWORD} in
        1)
            # Complete project IDs for first argument
            if command -v gcloud >/dev/null 2>&1; then
                local projects
                projects=$(gcloud projects list --format="value(projectId)" 2>/dev/null)
                COMPREPLY=($(compgen -W "${projects}" -- "${cur}"))
            fi
            ;;
        2)
            # Complete instance names for second argument
            if command -v gcloud >/dev/null 2>&1 && [[ -n "${prev}" ]]; then
                local instances
                instances=$(gcloud --project="${prev}" compute instances list --format="value(name)" 2>/dev/null)
                COMPREPLY=($(compgen -W "${instances}" -- "${cur}"))
            fi
            ;;
    esac
}

complete -F _gcp_ssh_tmux_completion gcp-ssh-tmux