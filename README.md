# .dotfiles

My dotfiles including:
- zsh
- neovim
- kitty
- homebrew (the bundle)

Made with Mac & Linux in mind, Windows might have some problems 😬 

## Prereqs
- [homebrew](https://brew.sh/)
- [nvm](https://github.com/nvm-sh/nvm)

## Usage
This is setup using [https://github.com/anishathalye/dotbot](dotbot), a tool that helps manage symlinks.

To create the symlinks, run `./install` in the root of this repo.

### Brewfile
The Brewfile holds onto all apps installed via Homebrew.
These are not handled by the install script and must be done manually with the command:

```sh
brew bundle install --file $DOTFILES/macos/Brewfile
```

## Manual configurations
### Setting Capslock as Ctrl/Escape
On macOS, this is easily done using [Karabiner](https://karabiner-elements.pqrs.org/).

On Windows, this is somewhat achieved using [PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/).

On Ubuntu (v22.04), this is less easily done with a few steps:
- Install GNOME Tweaks using `sudo apt install gnome-tweaks`
- In Tweaks, go to Keyboard & Mouse > Additional Layout Options > Ctrl position > Caps Lock as Ctrl
- Install xcape `sudo apt-get install xcape`
- Run `xcape -e Control_L=Escape` to map Control (now Caps Lock) as Escape when pressed
- This line is added to the `.profile` file so it runs on init

NOTE: xcape doesn't work properly with Wayland

### Font
Julia Mono: https://github.com/cormullion/juliamono/releases
