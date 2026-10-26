# Apple Terminal: install the dusk profile and make it the default for new windows.
#
# Terminal has no config directory; profiles live in the com.apple.Terminal preferences. On
# every switch this merges the .terminal file into an export of those preferences and imports
# the result back with `defaults`, which goes through cfprefsd and is safe while Terminal runs.
# Changes made in Terminal's settings UI are overwritten on the next switch, so edit the
# .terminal file instead (export it from Terminal > Settings > Profiles).
{ lib, ... }:

let
  profile = ./config/terminal/dusk.terminal;
  name = "dusk"; # must match the "name" key inside the .terminal file
in
{
  home.activation.terminalProfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    tmp=$(mktemp -d)
    prefs="$tmp/com.apple.Terminal.plist"
    /usr/bin/defaults export com.apple.Terminal "$prefs" 2>/dev/null \
      || /usr/bin/plutil -create xml1 "$prefs"

    pb() { /usr/libexec/PlistBuddy -c "$1" "$prefs" >/dev/null 2>&1 || true; }
    pb "Add ':Window Settings' dict"
    pb "Delete ':Window Settings:${name}'"
    pb "Add ':Window Settings:${name}' dict"
    /usr/libexec/PlistBuddy -c "Merge ${profile} ':Window Settings:${name}'" "$prefs" >/dev/null
    for key in "Default Window Settings" "Startup Window Settings"; do
      pb "Delete ':$key'"
      pb "Add ':$key' string ${name}"
    done

    run /usr/bin/defaults import com.apple.Terminal "$prefs"
    rm -rf "$tmp"
  '';
}
