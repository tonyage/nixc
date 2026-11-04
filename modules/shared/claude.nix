# Claude Code: a theme built from the platform's colorscheme, selected as the active theme.
#
# Claude Code loads custom themes from ~/.claude/themes/<slug>.json: a base theme plus
# per-color overrides (hex is accepted). Keys not overridden here keep the base's colors.
# The diff colors are backgrounds that need dark tints the colorscheme doesn't have, so they stay default.
#
# settings.json stays a regular file because Claude Code writes to it (model, plugins, ...);
# each switch only sets its "theme" key, so a theme picked with /theme lasts until then.
{
  colorscheme,
  lib,
  pkgs,
  ...
}:

let
  slug = colorscheme.name;

  theme = with colorscheme; {
    name = with lib.strings; toUpper (substring 0 1 slug) + substring 1 (-1) slug;
    base = "dark";
    overrides = {
      text = normal.white;
      inverseText = normal.black;
      inactive = gradients.dark.black90;
      inactiveShimmer = gradients.light.white00;
      subtle = gradients.dark.black25;
      promptBorder = gradients.dark.black90;
      promptBorderShimmer = gradients.light.white00;

      claude = normal.orange;
      claudeShimmer = bright.orange;
      clawd_body = normal.orange;
      clawd_background = normal.black;
      briefLabelClaude = normal.orange;
      briefLabelYou = normal.blue;
      fastMode = normal.orange;
      fastModeShimmer = bright.orange;

      claudeBlue_FOR_SYSTEM_SPINNER = normal.blue;
      claudeBlueShimmer_FOR_SYSTEM_SPINNER = bright.blue;
      permission = normal.blue;
      permissionShimmer = bright.blue;
      suggestion = normal.blue;
      remember = normal.blue;
      ide = normal.blue;
      professionalBlue = normal.blue;
      rate_limit_fill = normal.blue;
      rate_limit_empty = gradients.dark.black20;

      autoAccept = normal.magenta;
      autoAcceptShimmer = bright.magenta;
      skill = normal.magenta;
      merged = normal.magenta;
      effortUltra = normal.magenta;
      bashBorder = misc.pink;
      planMode = normal.cyan;
      background = normal.cyan;

      success = normal.green;
      error = normal.red;
      warning = normal.yellow;
      warningShimmer = bright.yellow;
      chromeYellow = normal.yellow;

      red_FOR_SUBAGENTS_ONLY = normal.red;
      blue_FOR_SUBAGENTS_ONLY = normal.blue;
      green_FOR_SUBAGENTS_ONLY = normal.green;
      yellow_FOR_SUBAGENTS_ONLY = normal.yellow;
      purple_FOR_SUBAGENTS_ONLY = normal.magenta;
      orange_FOR_SUBAGENTS_ONLY = normal.orange;
      pink_FOR_SUBAGENTS_ONLY = misc.pink;
      cyan_FOR_SUBAGENTS_ONLY = normal.cyan;

      userMessageBackground = gradients.dark.black10;
      userMessageBackgroundHover = gradients.dark.black15;
      composerSidebarBackground = gradients.dark.black05;
      bashMessageBackgroundColor = gradients.dark.black05;
      memoryBackgroundColor = gradients.dark.black05;
      selectionBg = gradients.dark.black20;
    };
  };
in
{
  home.file.".claude/themes/${slug}.json".text = builtins.toJSON theme;

  home.activation.claudeTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings="$HOME/.claude/settings.json"
    run mkdir -p "$HOME/.claude"
    [ -s "$settings" ] || (umask 077 && echo '{}' > "$settings")
    tmp=$(mktemp "$settings.XXXXXX")
    if ${lib.getExe pkgs.jq} '.theme = "custom:${slug}"' "$settings" > "$tmp"; then
      run mv "$tmp" "$settings"
    else
      rm -f "$tmp"
      warnEcho "could not set the Claude Code theme: $settings is not valid JSON"
    fi
  '';
}
