{ colorscheme, lib, pkgs, config, ... }:
with colorscheme;
let
  # githubPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrWClh0M5ZvQ+dL0C0xkWD4paUf2LxoyvADcJQpFZkW tdo@Tonys-MBP";
in
{
  # ".ssh/id_github.pub".text = githubPublicKey;
  ".config/bat/themes/dusk.tmTheme".source = config/bat/dusk.tmTheme;
  ".ideavimrc".text = ''
    set argtextobj
    set clipboard=unnamedplus,unnamed,ideaput
    set commentary
    set highlightedyank
    set hlsearch
    set ideajoin
    set ideaput
    set ideastatusicon
    set ideawrite=all
    set ignorecase
    set incsearch
    set numberline
    set relativenumber
    set showmode
    set showcmd
    set smartcase
    set sneak
    set surround
    set wrapscan

    let mapleader = " "

    map Y y$
    map <leader>f <Action>(ReformatCode)
    map <leader>o <Action>(OptimizeImports)
    map <leader>d <Action>(Debug)
    map <leader>b <Action>(ToggleLineBreakpoint)
    map <leader>r <Action>(Run)
    map <leader>s <Action>(Stop)
    map <leader>ch <Action>(CallHierarchy)
    map <leader>chm <Action>(CallHierarchy.BaseOnThisMethod)

    sethandler <c-h> Vim
    sethandler <c-l> Vim
    sethandler <c-j> Vim
    sethandler <c-k> Vim
    sethandler <a-s-h> Vim
    sethandler <a-s-l> Vim
    sethandler <c-s-t> Vim

    nmap <c-h> <C-W>h
    nmap <c-j> <C-W>j
    nmap <c-k> <C-W>k
    nmap <c-l> <C-W>l

    vnoremap < <gv
    vnoremap > >gv
    vnoremap = =gv

    map <a-b> <Action>(ActivateBuildToolWindow)
    map <a-g> <Action>(ActivateGradleToolWindow)
    map <a-l> <Action>(ActivateLogcatToolWindow)
    map <a-s-l> <Action>(SplittingTabsToolWindow.MoveTabRight)
    map <a-s-h> <Action>(SplittingTabsToolWindow.MoveTabLeft)
    map <c-s-t> <Action>(ReopenClosedTab)

    nmap = <Action>(EditorIncreaseFontSize)
    nmap - <Action>(EditorDecreaseFontSize)
    nmap gu <Action>(ShowUsages)
    nmap gt <Action>(GotoDeclaration)
    nmap gi <Action>(GotoImplementation)
    nmap gs <Action>(GotoSuperMethod)
    nmap gp <Action>(ParameterInfo)
    nmap gf <Action>(GotoFile)
    nmap gc <Action>(CommentByLineComment)
    nmap ge <Action>(ShowErrorDescription)

    nmap <TAB> <Action>(NextTab)
    nmap <S-TAB> <Action>(PreviousTab)

    nmap grn <Action>(RenameElement)
    nmap grg <Action>(Generate)
  '';
  ".config/btop/themes/dusk.theme".text = ''
  # Theme: dusk
  # By: tonyage

  # Main bg
  theme[main_bg]="${normal.black}"

  # Main text color
  theme[main_fg]="${bright.white}"

  # Title color for boxes
  theme[title]="${bright.white}"

  # Highlight color for keyboard shortcuts
  theme[hi_fg]="${bright.blue}"

  # Background color of selected item in processes box
  theme[selected_bg]="${gradients.dark.black10}"

  # Foreground color of selected item in processes box
  theme[selected_fg]="${bright.white}"

  # Color of inactive/disabled text
  theme[inactive_fg]="${gradients.dark.black25}"

  # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
  theme[proc_misc]="${bright.blue}"

  # Cpu box outline color
  theme[cpu_box]="${normal.orange}"

  # Memory/disks box outline color
  theme[mem_box]="${normal.magenta}"

  # Net up/down box outline color
  theme[net_box]="${normal.cyan}"

  # Processes box outline color
  theme[proc_box]="${normal.red}"

  # Box divider line and small boxes line color
  theme[div_line]="${gradients.dark.black25}"

  # Temperature graph colors
  theme[temp_start]="${bright.green}"
  theme[temp_mid]="${bright.yellow}"
  theme[temp_end]="${bright.red}"

  # CPU graph colors
  theme[cpu_start]="${bright.green}"
  theme[cpu_mid]="${bright.yellow}"
  theme[cpu_end]="${bright.red}"

  # Mem/Disk free meter
  theme[free_start]="${bright.green}"
  theme[free_mid]="${bright.yellow}"
  theme[free_end]="${bright.red}"

  # Mem/Disk cached meter
  theme[cached_start]="${bright.green}"
  theme[cached_mid]="${bright.yellow}"
  theme[cached_end]="${bright.red}"

  # Mem/Disk available meter
  theme[available_start]="${bright.green}"
  theme[available_mid]="${bright.yellow}"
  theme[available_end]="${bright.red}"

  # Mem/Disk used meter
  theme[used_start]="${bright.green}"
  theme[used_mid]="${bright.yellow}"
  theme[used_end]="${bright.red}"

  # Download graph colors
  theme[download_start]="${bright.green}"
  theme[download_mid]="${bright.yellow}"
  theme[download_end]="${bright.red}"

  # Upload graph colors
  theme[upload_start]="${bright.green}"
  theme[upload_mid]="${bright.yellow}"
  theme[upload_end]="${bright.red}"
  '';
  ".config/ghostty/config".text = ''
  window-colorspace = "display-p3"

  palette = 0=${normal.black}
  palette = 1=${bright.red}
  palette = 2=${bright.green}
  palette = 3=${bright.yellow}
  palette = 4=${bright.blue}
  palette = 5=${bright.magenta}
  palette = 6=${bright.cyan}
  palette = 7=${bright.white}
  palette = 8=${normal.black}
  palette = 9=${normal.red}
  palette = 10=${normal.green}
  palette = 11=${normal.yellow}
  palette = 12=${normal.blue}
  palette = 13=${normal.magenta}
  palette = 14=${normal.cyan}
  palette = 15=${normal.white}

  adjust-cell-height = 20%
  adjust-cursor-height = 20%
  window-height = 50
  window-width = 180

  cursor-color = ${lib.strings.removePrefix "#" normal.white}
  cursor-style = block
  cursor-style-blink = true
  shell-integration-features = no-cursor
  font-size = 12

  background = ${lib.strings.removePrefix "#" normal.black}
  foreground = ${lib.strings.removePrefix "#" normal.white}
  '';
}
