# ===== INSTANT PROMPT (must be at top) =====
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===== ZINIT SETUP =====
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Hihglighting plugins
zinit light zsh-users/zsh-syntax-highlighting

# ===== AUTO COMPLETION PLUGINS =====
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# ===== OTHER PLUGINS =====
# Better vim mode but it's a little buggy and heavy
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode

zinit ice depth=1; zinit light romkatv/powerlevel10k

# ===== COMPLETIONS =====
autoload -Uz compinit && compinit
zinit cdreplay -q

# ===== KEYBINDINGS =====
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^y' autosuggest-accept
bindkey -M viins '^h' backward-delete-char 
bindkey -M viins '' backward-delete-char 

# Bind Ctrl+W in Vim insert mode
# Delete backwards until the previous whitespace
bindkey -M viins '^W' vi-backward-kill-word

# ===== HISTORY =====
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ===== COMPLETION STYLING =====
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ===== ALIASES & INTEGRATIONS =====
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

eval "$(fzf --zsh --bind 'ctrl-y:accept')"
eval "$(zoxide init --cmd cd zsh)"

# ===== ENVIRONMENT VARIABLES =====
export BRC=~/.zshrc
export NVIM_HOME="$HOME/AppData/Local/nvim"
export NVIM_CONF="$HOME/AppData/Local/nvim"
export GLAZE_CONF="$HOME/.glzr/glazewm"
export AHK_CONF="$HOME/.ahk/"
export AP="/c/school/ap-j2/"
export SCHOOL="/c/school/"
export TERM_CONF="$HOME/.wezterm.lua"
export EDITOR='vim'

# ===== CUSTOM ALIASES =====
alias school="ssh student@10.158.10.6"
alias sofproj="ssh student@195.201.32.128"
alias privvm="ssh yazan@138.199.212.73"
alias ap="cd /c/school/ap-j3/"
alias ap2="cd /c/school/ap-j2/"
alias proj="cd /c/school/ap-j2/software_project/gosmartlib"

# ===== FUNCTIONS (keep all your existing functions) =====

# Functions
javap() {
    mvn archetype:generate -DgroupId=$2 -DartifactId=$1 -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.5 -DinteractiveMode=false
}

javar() {
    mvn exec:java -Dexec.mainClass=$1
}

t() {
    touch $@
}

..() {
    cd ..
}

netef() {
    local db=$1
    
    if [[ $db == "" ]]; then
        db=SqlServer
    fi
    
    dotnet add package Microsoft.EntityFrameworkCore.$db
    dotnet add package Microsoft.EntityFrameworkCore
    dotnet add package Microsoft.EntityFrameworkCore.Relational
    dotnet add package Microsoft.EntityFrameworkCore.Tools
}

netc() {
    dotnet new class -n $1 -o $2
}

netcon() {
    dotnet new apicontroller -n $1 -o $2
}

netefup() {
    dotnet ef database update
}

netefmig() {
    dotnet ef migrations $1 $2
}

runAsAdmin() {
    powershell -Command "Start-Process '$1' -Verb RunAs"
}

addAppToRunAtRuntime() {
    powershell -Command "$action = New-ScheduledTaskAction -Execute '$1' -Argument '$2'; $trigger = New-ScheduledTaskTrigger -AtLogOn; $principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Highest; Register-ScheduledTask -TaskName '$3' -Action $action -Trigger $trigger -Principal $principal -Force"
}

reboot() {
    shutdown -r -f -t 0
}

# fzf cd
fcd() {
    local dir file execution_path
    execution_path=$(pwd)
    fzf_path="$1"
    
    if [[ -z "$fzf_path" ]]; then
        fzf_path="."
    fi
    cd $fzf_path
    file=$(fzf)
    if [[ $? -ne 0 ]]; then
        cd $execution_path
        return
    fi
    dir=$(echo "${file%/*}") && cd "$dir"
}

# Yazi integration
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    if [[ -f "$tmp" ]]; then
        cwd="$(cat "$tmp")"
        if [[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    fi
}

addToPath() {
    local newPath="$1"

    powershell -NoProfile -Command "
        \$newPath = [System.IO.Path]::GetFullPath('$newPath')
        \$current = [Environment]::GetEnvironmentVariable('Path', 'Machine')

        \$paths = \$current -split ';'

        if (\$paths -notcontains \$newPath) {
            \$updated = (\$paths + \$newPath) -join ';'
            [Environment]::SetEnvironmentVariable('Path', \$updated, 'Machine')
            Write-Host 'Added to PATH:' \$newPath
        }
        else {
            Write-Host 'Already in PATH:' \$newPath
        }
    "
}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function addEnvironmentVariable() {
    powershell -Command "[Environment]::SetEnvironmentVariable('$1', '$2', 'User')"
} 

function bottom_prompt() {
  local end=$(tput cup 9999 0)
  print -n -- "$end"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd bottom_prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


# Usage: setpower <mode>
#   0 → Best power efficiency
#   1 → Balanced
#   2 → Best performance
# Requires administrator privileges (run your bash terminal as Admin).

setpower() {
  case "$1" in
    0) guid="961cc777-2547-4f9d-8174-7d86181b8a7a" ;;   # Best power efficiency
    1) guid="00000000-0000-0000-0000-000000000000" ;;   # Balanced
    2) guid="ded574b5-45a0-4f42-8737-46345c09c238" ;;   # Best performance
    *) echo "Usage: setpower {0|1|2}" >&2; return 1 ;;
  esac

  powershell.exe -Command "& {
    powercfg /setacvalueindex scheme_current overlay 3b04c4cb-1a9a-493a-8143-ff9c4a94225c $guid;
    powercfg /setdcvalueindex scheme_current overlay 3e00f420-8d3c-4c8d-b004-7ad15a670fc7 $guid;
    powercfg /setactiveoverlay SCHEME_CURRENT
  }"
}


# Intresting commands
# This takes the last 10 files/directories and give them the user, the user then can select 1 or multiple files/dir (via <Tab>) and then move them to `tmp`
# mv $(fd . ~/Downloads  -a -x stat -c "%Y;%y;%n" | sort -nr | head | cut -d";" -f 3 | fzf -m) tmp

