# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim
export DEFAULT_USER="$(whoami)"
# Saves 10 million lines in memory and in the bash history file.
export HISTSIZE=10000000
export GPG_TTY=`tty`

# ctrl+D won't logout the shell
set -o ignoreeof

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export PATH=~/.nimble/bin:$PATH
export PATH=~/go/bin:$PATH
export PATH=~/.cargo/bin:$PATH
export PATH=/usr/local/Cellar/ruby/2.7.1_2/bin:$PATH
# aliases
alias c=clear
alias p=python3
alias sv="source venv/bin/activate"
alias ipython='p -m IPython'
alias pip='p -m pip'
alias pipupgrade='pip install --upgrade pip'
alias sv='source venv/bin/activate'
alias venv='p -m venv venv && sv && pipupgrade && pip install wheel'
alias pir='pip install -r requirements.txt'
alias psecrets='p -c "import secrets; print(secrets.token_urlsafe(50))"'
alias lab='jupyter lab'
alias ls='ls -G'
alias l=ls
alias ll='l -lh'
alias la='l -a'
alias lla='l -alh'
alias mycc="cc -std=c99 -Wall -pedantic -Werror"
alias m=make
alias mc="make clean"
alias mr="make run"
alias brewup='brew update && brew upgrade && brew cleanup --prune-prefix && brew doctor'
alias de=deactivate
alias jl='jupyter lab'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/python@3.8/bin:$PATH"

export PROJECT_ENV=development

source ~/.zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh

zplug "zsh-users/zsh-history-substring-search"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
zplug "hlissner/zsh-autopair"
# gets wifi password (macOS only)
zplug "rauchg/wifi-password"

# antigen theme agnoster
zplug "romkatv/powerlevel10k", as:theme
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
