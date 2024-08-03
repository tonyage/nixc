#!/usr/bin/env zsh
gi() {
  curl -sL https://www.gitignore.io/api/$argv >> ./.gitignore
}

bdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

help() {
  "$@" --help 2>&1 | bat --plain --language=help
}

chpwd() {
  echo "\x1b]1337;SetUserVar=panetitle=$(echo -n $(basename $(pwd)) | base64)\x07"
}

trn() {
  wezterm cli set-tab-title "$@"
}
