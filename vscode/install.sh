#!/bin/bash
#
# Tommaso Amici
# install.sh is a script to restore vscode's
# preferences, snippets, and extensions from backup

if [[ "$OSTYPE" == "linux"* ]]; then
    #TODO
    echo "Can't install now"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # add vscode to PATH
    echo 'export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' >> ~/dotfiles/zshrc
    export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

    # link preferences
    VSCODE_PATH="~/Library/Application\ Support/Code/User"
    ln -s keybindings.json $VSCODE_PATH/keybindings.json
    ln -s settings.json $VSCODE_PATH/settings.json

    # link snippets
    for f in snippets/*
    do
        ln -s f $VSCODE_PATH/$f
    done

    # install extensions
    cat extensions | while read ext
    do
        code --install-extension $ext
    done
fi

