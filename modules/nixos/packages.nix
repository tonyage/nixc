{ pkgs }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
in
shared-packages
++ [

  # Security and authentication
  yubikey-agent
  keepassxc

  # App and package management
  appimage-run
  gnumake
  cmake
  home-manager

  # Media and design tools
  vlc
  fontconfig
  font-manager

  # Productivity tools
  bc # old school calculator
  galculator

  # Audio tools
  cava # Terminal audio visualizer
  pavucontrol # Pulse audio controls

  # Testing and development tools
  direnv
  postgresql

  # Text and terminal utilities
  tree
  unixtools.ifconfig
  unixtools.netstat
  wl-clipboard # Wayland clipboard provider for neovim's "+ register

  # File and system utilities
  inotify-tools # inotifywait, inotifywatch - For file system events
  libnotify
  sqlite
  xdg-utils

  # Other utilities
  google-chrome

  # PDF viewer
  zathura

  # Music and entertainment
  spotify
]
