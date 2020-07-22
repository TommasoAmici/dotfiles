# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim
export DEFAULT_USER="$(whoami)"

# ctrl+D won't logout the shell
set -o ignoreeof

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
source ~/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle hlissner/zsh-autopair
# gets wifi password (macOS only)
antigen bundle rauchg/wifi-password

# antigen theme agnoster
antigen theme romkatv/powerlevel10k
antigen apply
plugins=(copyzshell)
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
alias venv='p -m venv venv'
alias pir='pip install -r requirements.txt'
alias psecrets='p -c "import secrets; print(secrets.token_urlsafe(50))"'
alias lab='jupyter lab'
alias l=ls
alias la='ls -a'
alias mycc="cc -std=c99 -Wall -pedantic -Werror"
alias m=make
alias mc="make clean"
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias sv='source venv/bin/activate'
alias de=deactivate
alias jl='jupyter lab'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/python@3.8/bin:$PATH"

export PROJECT_ENV=development
