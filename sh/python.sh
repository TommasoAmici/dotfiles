#!/bin/sh
export PYTHONUNBUFFERED=1
export PYTHONDONTWRITEBYTECODE=1

alias p=python3
alias sv="source venv/bin/activate"
alias de=deactivate
alias ipython='p -m IPython'
alias pip='p -m pip'
alias pir='pip install -r requirements.txt'
alias pyserve="p -m http.server"

venv() {
  python3 -m venv venv &&
    . venv/bin/activate &&
    python -m pip install --upgrade pip wheel &&
    python -m pip install -r requirements.txt
}
