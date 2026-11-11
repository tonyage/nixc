_: [
  # { name = "qmk/qmk/qmk"; }
  # { name = "koekeishiya/formulae/yabai" }
  # {
  #   name = "koekeishiya/formulae/skhd";
  #   restart_service = true;
  #   link = true;
  # }

  { name = "go"; }
  { name = "marksman"; } # nixpkgs' needs .NET, uncached on aarch64-darwin (see neovim.nix)
  { name = "xcodegen"; }
  { name = "yt-dlp"; }
]
