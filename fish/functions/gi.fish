function gi --description 'generate .gitignore'
    argparse h/help i/interactive -- $argv
    or return

    # # If -h or --help is given, we print a little help text and return
    if set -ql _flag_help
        echo "gi [-h|--help] [-i|--interactive] [ARGUMENT ...]"
        return 0
    end

    function _make_gitignore
        set REQUEST (string join , $argv | string trim --chars=,)
        curl --silent "https://www.toptal.com/developers/gitignore/api/$REQUEST"
    end

    if set -ql _flag_interactive
        if command -q fzf
          function _list_options
            curl --silent "https://www.toptal.com/developers/gitignore/api/list" | tr ',' '\n'
          end

          set GI_LIST (_list_options | fzf --multi | tr '\n' ',')
          _make_gitignore $GI_LIST
        else
          echo "fzf not installed, cannot run gi in interactive mode"
        end
    else
        _make_gitignore $argv
    end
end