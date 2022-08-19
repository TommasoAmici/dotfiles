#!/bin/bash
if [[ "$OSTYPE" == "linux"* ]]; then

  # install packages
  # git repository
  sudo add-apt-repository ppa:git-core/ppa

  # update packages
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade

  sudo apt-get install git python3 python3-pip vim zsh

  # nodejs
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt-get install -y nodejs
  npm install --global yarn

  # ripgrep
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
  sudo dpkg -i ripgrep_0.8.1_amd64.deb
fi
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  xcode-select --install
  # install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  brew update
  brew bundle
fi
# platform agnostic
# update python packages
pip install --upgrade setuptools
pip install --upgrade pip

# get dotfiles
git clone https://github.com/TommasoAmici/dotfiles.git
rm .vimrc .zshrc

# set up vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s dotfiles/vim/vimrc ~/.vimrc

# set up zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -L git.io/antigen >antigen.zsh

ln -s dotfiles/zshrc ~/.zshrc
ln -s dotfiles/gitconfig ~/.gitconfig
ln -s dotfiles/gitconfig-personal ~/.gitconfig-personal
