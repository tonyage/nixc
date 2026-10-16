{ pkgs }:

with pkgs;
[
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  black
  btop
  clang-tools
  coreutils
  isort
  killall
  neovim
  openssh
  protobuf
  ruff
  rustc
  cargo
  rustfmt
  shellcheck
  shfmt
  sqruff
  treefmt
  uv
  wget
  zip

  # Language servers
  gopls
  marksman
  spectral-language-server
  yaml-language-server

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-color-emoji
  meslo-lgs-nf
  nerd-fonts.jetbrains-mono
  transmission_4

  # Node.js development tools
  pnpm # globally install npm
  prettier
  nodejs

  # llm tooling
  opencode
  opencode-claude-auth

  # Text and terminal utilities
  htop
  jq
  ripgrep
  tmux
  unzip
  luarocks
  statix
  yamlfmt
  yamllint
]
