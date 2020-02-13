# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
source ~/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle desyncr/auto-ls
antigen bundle hlissner/zsh-autopair
# gets wifi password (macOS only)
antigen bundle rauchg/wifi-password

antigen theme agnoster

antigen apply
plugins=(copyzshell)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}
export PATH=~/.nimble/bin:$PATH
export PATH=~/go/bin:$PATH
# aliases
alias c=clear
alias p=python3
alias sv="source venv/bin/activate"
alias ipython='p -m IPython'
alias pip='p -m pip'
alias lab='jupyter lab'
alias l=ls
alias la='ls -a'
alias mycc="cc -std=c99 -Wall -pedantic -Werror"
alias m=make
alias mc="make clean"
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
