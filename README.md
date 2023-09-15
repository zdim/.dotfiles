# .dotfiles

My dotfiles including:
- zsh
- neovim
- kitty
- homebrew (the bundle)

Made with Mac & Linux in mind, Windows might have some problems 😬 

## Usage
This is setup using [https://github.com/anishathalye/dotbot](dotbot), a tool that helps manage symlinks.

To create the symlinks, run `./install` in the root of this repo.

### Brewfile
The Brewfile holds onto all apps installed via Homebrew.
These are not handled by the install script and must be done manually with the command:

```sh
brew bundle install --file $DOTFILES/macos/Brewfile
```

## Not yet included
- Fonts
- VS Codium
- Windows support
