#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install `wget` with IRI support.
brew install wget --with-iri
# Install zsh
brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting

# Switch to zsh shell
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

# Install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

# Install starship CLI
brew install starship

# Install GPG suite to sign commits
brew install --cask gpg-suite-no-mail

# Install more recent versions of some macOS tools.
PACKAGES=(
  grep
  openssh
  screen
  pgp
  gmp
  git
  git-lfs
  gs
  lua
  lynx
  p7zip
  pigz
  pv
  rename
  rlwrap
  ssh-copy-id
  tree
  vbindiff
  zopfli
  node
  youtube-dl
  zeromq
  yarn
  wp-cli
  thefuck
  volta
  sqlite
  ripgrep
  rclone
  python@3
  pyenv
  pipenv
  exa
  fd
  ffmpeg
  fx
  fzf
  gh
  jq
  lsd
  bat
  awscli
  brotli
  git-delta
  git-recent
  git-secrets
  glow
  graphviz
  grex
  howdoi
  httpie
  mcfly
  nano
  neovim
  tfenv
  tldr
  watchman
)
brew install ${PACKAGES[@]}
brew install vim --with-override-system-vi

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Development tools
brew install imagemagick --with-webp

npm install -g n serve

# Remove outdated versions from the cellar.
brew cleanup

# === Configure macos ===

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Configure Firewall

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo pkill -HUP socketfilterfw # restart



