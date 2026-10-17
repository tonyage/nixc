# Neovim with the LazyVim config from github.com/tonyage/nvim.
#
# Nix provides neovim and every external tool the config calls (LSPs, formatters, linters);
# lazy.nvim keeps managing plugins. The config stays a regular git checkout at ~/.config/nvim
# so it can be edited and pushed, and lazy.nvim can write lazy-lock.json.
{ lib, pkgs, ... }:

let
  # Repos cloned on first activation, relative to $HOME. Existing directories are never touched.
  repos = [
    {
      url = "git@github.com:tonyage/nvim.git";
      path = ".config/nvim";
    }
    # dusk colorscheme; the nvim config loads it from here (lua/plugins/theme.lua, `dir = ...`)
    {
      url = "git@github.com:tonyage/dusk.git";
      path = ".config/dusk";
    }
  ];

  clone =
    { url, path }:
    ''
      if [ ! -e "$HOME/${path}" ]; then
        run mkdir -p "$(dirname "$HOME/${path}")"
        if GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh" run ${pkgs.git}/bin/git clone --quiet ${url} "$HOME/${path}"; then
          noteEcho "Cloned ${url} to ~/${path}"
        else
          warnEcho "Could not clone ${url} (no GitHub access yet?); it will be retried on the next switch"
        fi
      fi
    '';
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # Load home-manager's generated init (provider settings) through the wrapper instead of
    # writing ~/.config/nvim/init.lua, which belongs to the cloned config
    sideloadInitLua = true;

    # On neovim's PATH only (not the shell's); replaces mason, which is disabled in the config
    extraPackages =
      with pkgs;
      [
        # LazyVim core
        ripgrep
        fd
        lazygit
        tree-sitter # nvim-treesitter (main branch) builds parsers with the CLI
        nodejs
        lua-language-server
        stylua
        shfmt

        # lang extras enabled in lazyvim.json
        clang-tools # clangd
        neocmakelsp
        dockerfile-language-server
        docker-compose-language-service
        hadolint
        marksman
        markdownlint-cli2
        nil
        nixfmt
        pyright
        ruff
        rust-analyzer
        taplo
        sqlfluff
        yaml-language-server
        zls
      ]
      # C compiler for treesitter parsers; macOS uses the Xcode command line tools' clang
      ++ lib.optional pkgs.stdenv.hostPlatform.isLinux gcc;
  };

  # Clone the config and the repos it depends on; never touch an existing directory
  home.activation.cloneNeovimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    lib.concatMapStrings clone repos
  );
}
