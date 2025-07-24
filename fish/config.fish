if status is-interactive
    set -x ELIXIR_ERL_OPTIONS "-kernel shell_history enabled"
    set -x MISE_ENV_FILE '.env'

    abbr --add p python3
    abbr --add de deactivate
    abbr --add sv ". .venv/bin/activate.fish"
    abbr --add tf terraform
    abbr --add m make
    abbr --add mr "make run"
    abbr --add l ls
    abbr --add ga "git add"
    abbr --add gc "git commit"

    fzf --fish | source
    zoxide init --cmd cd fish | source
    atuin init fish --disable-up-arrow | source
    mise activate fish | source
end
