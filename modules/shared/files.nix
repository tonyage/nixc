{ pkgs, config, ... }:

let
  githubPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrWClh0M5ZvQ+dL0C0xkWD4paUf2LxoyvADcJQpFZkW tdo@Tonys-MBP";
in
{

  ".ssh/id_github.pub".text = githubPublicKey;

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
}
