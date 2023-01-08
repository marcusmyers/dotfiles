#!/bin/zsh

# Commands
GIT="/usr/bin/git"
DEFAULTS="/usr/bin/defaults"
AUTOPKG="/usr/local/bin/autopkg"
PLISTBUDDY="/usr/libexec/PlistBuddy"

# logger
LOGGER="/usr/bin/logger -t AutoPkg_Setup"
AUTOPKG_LATEST=$(curl https://api.github.com/repos/autopkg/autopkg/releases/latest | python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj["assets"][0]["browser_download_url"])')

/usr/bin/curl -L "${AUTOPKG_LATEST}" -o "$HOME/autopkg-latest.pkg"

sudo installer -pkg "$HOME/autopkg-latest.pkg" -target /

autopkg_version=$(${AUTOPKG} version)

${LOGGER} "AutoPkg $autopkg_version Installed"
echo
echo "### AutoPkg $autopkg_version Installed"
echo

# Clean Up When Done
rm "$HOME/autopkg-latest.pkg"
