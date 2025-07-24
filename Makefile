brew_dump:
	brew bundle dump --force --describe

symlinks:
	ln -s ~/dotfiles/zed ~/.config/zed
	ln -s ~/dotfiles/fish ~/.config/fish
