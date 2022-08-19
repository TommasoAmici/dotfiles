#!/bin/sh
# macOS installation script

DOTFILES="$HOME/dotfiles"

# set up zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
rm -f ~/.zshrc && ln -s "$DOTFILES/zshrc" ~/.zshrc

rm -f ~/.ssh/config && ln -s "$DOTFILES/ssh/config" ~/.ssh/config

if [ "$(uname)" = "Darwin" ]; then
  xcode-select --install
  # install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  brew update
  brew bundle --file "$DOTFILES/Brewfile"
fi

# set up vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
rm -f ~/.vimrc && ln -s "$DOTFILES/vim/vimrc" ~/.vimrc

ln -s "$DOTFILES/gitconfig" ~/.gitconfig
ln -s "$DOTFILES/gitconfig-personal" ~/.gitconfig-personal

# link topgrade config
rm -f ~/.config/topgrade.toml &&
  ln -s "$DOTFILES/topgrade.toml" ~/.config/topgrade.toml

# link helix config
mkdir -p ~/.config/helix && rm -f ~/.config/helix/config.toml &&
  ln -s "$DOTFILES/helix/config.toml" ~/.config/helix/config.toml

topgrade

# clone repos from github
if [ -z "$GITHUB_TOKEN" ]; then
  REPOS_DIR="$HOME/dev/personal"
  mkdir -p "$REPOS_DIR" &&
    ghorg clone TommasoAmici --clone-type=user --token="$GITHUB_TOKEN" \
      --output-dir="$REPOS_DIR" --skip-forks
fi
