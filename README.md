# dofiles

My dotfiles

## Structure

- `cli-tools` - configuration for many different cli tools (ex. `gh`)
- `git` - configuration for git
- `nano` - configuration for nano editor (used on accidents instead of vim)
- `vim` - main configuration for neovim
- `zsh` - configuration for zsh shell
- `terminal` - configuration for kitty terminal emulator (and others for fun)
- `scripts` - scripts stored in main use directory
    - `switch-gpu` - switching between integrated and discrete GPU on MacBooks that has a AMD graphics card
    - `macos.sh` - to be replaced with something better

## How to install

1. `./scripts/macos.sh` - installs basic stuff for macOS
2. `stow <directory-name>` - installs configuration using [GNU Stow](https://www.gnu.org/software/stow/)

