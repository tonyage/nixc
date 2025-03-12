#!/usr/bin/env bash

source ./stdio.sh

insert_secrets_input() {
  # Define file path
  FILE_PATH="flake.nix"

  # Backup the original file
  cp "$FILE_PATH" "${FILE_PATH}.bak"

  # Temporary file for the text to insert
  TEMP_FILE="temp_insert.txt"

  # Write the formatted text to the temporary file
  cat >"$TEMP_FILE" <<'EOF'
    secrets = {
      url = "git+ssh://git@github.com/%GITHUB_USER%/%GITHUB_SECRETS_REPO%.git";
      flake = false;
    };
EOF

  # Check if the 'secrets' block already exists
  if grep -q 'url = "git+ssh://git@github.com/%GITHUB_USER%/%GITHUB_SECRETS_REPO%.git"' "$FILE_PATH"; then
    echo "The 'secrets' block already exists in the file."
    rm "$TEMP_FILE"
    rm "${FILE_PATH}.bak"
    exit 0
  fi

  # Find the start and end line numbers of the 'disko' block
  START_LINE=$(grep -n 'disko = {' "$FILE_PATH" | head -n 1 | cut -d: -f1)
  END_LINE=$(tail -n +$START_LINE "$FILE_PATH" | grep -n '};' | head -n 1 | cut -d: -f1)
  END_LINE=$((START_LINE + END_LINE - 1))

  # Create a new file with the insertion
  {
    sed -n "1,${END_LINE}p" "$FILE_PATH"
    cat "$TEMP_FILE"
    sed -n "$((END_LINE + 1)),\$p" "$FILE_PATH"
  } >"${FILE_PATH}.new"

  # Replace the original file with the new file
  mv "${FILE_PATH}.new" "$FILE_PATH"

  # Clean up the temporary files
  rm "$TEMP_FILE"
  rm "${FILE_PATH}.bak"
}

insert_secrets_output() {
  local pattern="outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, nixpkgs, disko, agenix } @inputs:"
  local insert_text="secrets "

  awk -v pat="$pattern" -v insert="$insert_text" '
    $0 ~ pat {
      sub(/} @inputs:/, ", " insert "} @inputs:"); # Replace the closing brace with the insert text followed by the brace
      gsub(/ ,/, ","); # Correct any spaces before commas
      print
      next
    }
    { print }
  ' flake.nix >flake.nix.tmp

  mv flake.nix.tmp flake.nix
}

replace_tokens() {
  local file="$1"
  if [[ $(basename "$1") != "apply" ]]; then
    if [[ "$OS" == "Darwin" ]]; then
      # macOS
      LC_ALL=C LANG=C sed -i '' -e "s/%USER%/$USER/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%EMAIL%/$GIT_EMAIL/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%NAME%/$GIT_NAME/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%GITHUB_USER%/$GITHUB_USER/g" "$file"
      LC_ALL=C LANG=C sed -i '' -e "s/%GITHUB_SECRETS_REPO%/$GITHUB_SECRETS_REPO/g" "$file"
    else
      # Linux or other
      sed -i -e "s/%USER%/$USER/g" "$file"
      sed -i -e "s/%EMAIL%/$GIT_EMAIL/g" "$file"
      sed -i -e "s/%NAME%/$GIT_NAME/g" "$file"
      sed -i -e "s/%INTERFACE%/$PRIMARY_IFACE/g" "$file"
      sed -i -e "s/%DISK%/$BOOT_DISK/g" "$file"
      sed -i -e "s/%HOST%/$HOST_NAME/g" "$file"
      sed -i -e "s/%GITHUB_USER%/$GITHUB_USER/g" "$file"
      sed -i -e "s/%GITHUB_SECRETS_REPO%/$GITHUB_SECRETS_REPO/g" "$file"
    fi
  fi
}
