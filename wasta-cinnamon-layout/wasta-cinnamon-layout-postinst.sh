#!/bin/bash

# ==============================================================================
# wasta-cinnamon-layout-postinst.sh
#
#   This script is automatically run by the postinst configure step on
#       installation of wasta-cinnamon-*. It can be manually re-run, but
#       is only intended to be run at package installation.
#
#   2018-01-05 rik: initial release
#   2018-01-18 rik: transparent-panels: set first-launch default to false
#   - ITM thumbnail-size default=8
#   2018-02-28 rik: ITM - include-all-windows: set to "false"
#   - ITM: thumbnail-padding: set to 5
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Check to ensure running as root
# ------------------------------------------------------------------------------
#   No fancy "double click" here because normal user should never need to run
if [ $(id -u) -ne 0 ]
then
	echo
	echo "You must run this script with sudo." >&2
	echo "Exiting...."
	sleep 5s
	exit 1
fi

# ------------------------------------------------------------------------------
# Initial setup
# ------------------------------------------------------------------------------

echo
echo "*** Script Entry: wasta-cinnamon-layout-postinst.sh"
echo

# Setup Diretory for later reference
DIR=/usr/share/wasta-cinnamon-layout

# ------------------------------------------------------------------------------
# Applet / Extension adjustments
# ------------------------------------------------------------------------------

# Making adjustments here (instead of login script) since only we place these
#   applets at the system level so don't need to be concerned they will be
#   overridden by any updates to cinnamon, etc.

# applet: calendar@simonwiles.net
JSON_FILE=/usr/share/cinnamon/applets/calendar@simonwiles.net/settings-schema.json
echo "updating JSON_FILE: $JSON_FILE"
# updates:
# - use-custom-format: custom panel clock format
# - custom-format: set to "%l:%M %p"
# - note: jq can't do "sed -i" inplace update, so need to re-create file, then
#     update ownership (in case run as root)
NEW_FILE=$(jq '.["use-custom-format"].default=true | .["custom-format"].default="%l:%M %p"' \
    < $JSON_FILE)
echo "$NEW_FILE" > $JSON_FILE

# applet: IcingTaskManager@json
JSON_FILE=/usr/share/cinnamon/applets/IcingTaskManager@json/3.*/settings-schema.json
echo "updating JSON_FILE: $JSON_FILE"
# updates:
# - number-display: for "all open apps" (rather than only showing number if more than 1)
# - pinned-apps: wasta defaults
# - cycleMenusHotkey: disable (wast defaulted to super+space which is for ibus)
# - enable-hover-peek: disable (so no "flashing" on screen when hovering previews)
# - icon-spacing: spread out a bit (too crowded by default) and set max a bit bigger
# - icon-padding: increase a bit again for a bit of padding between items
# - include-all-windows: set to "false" so child windows aren't shown
# - thumbnail-padding: set to 5 (for space around thumbnails)
# - thumbnail-size: set to 8
# - note: jq can't do "sed -i" inplace update, so need to re-create file, then
#     update ownership (in case run as root)
NEW_FILE=$(jq '.["number-display"].default=2 | .["pinned-apps"].default=["firefox.desktop", "thunderbird.desktop", "nemo.desktop", "libreoffice-writer.desktop", "vlc.desktop"] | .["cycleMenusHotkey"].default="" | .["enable-hover-peek"].default=false | .["icon-spacing"].default=15 | .["icon-spacing"].max=21 | .["icon-padding"].default=11 | .["include-all-windows"].default=false | .["thumbnail-padding"].default=5 | .["thumbnail-size"].default=8' \
    < $JSON_FILE)
echo "$NEW_FILE" > $JSON_FILE

# extension: transparent-panels@germanfr
JSON_FILE=/usr/share/cinnamon/extensions/transparent-panels@germanfr/settings-schema.json
echo "updating JSON_FILE: $JSON_FILE"
# updates:
# - set transparency to "semi-transparent"
# - note: jq can't do "sed -i" inplace update, so need to re-create file, then
#     update ownership (in case run as root)
NEW_FILE=$(jq '.["transparency-type"].default="panel-transparent-semi__internal" | .["first-launch"].default=false' \
    < $JSON_FILE)
echo "$NEW_FILE" > $JSON_FILE

# ------------------------------------------------------------------------------
# Dconf / Gsettings Default Value adjustments
# ------------------------------------------------------------------------------
echo
echo "*** Updating dconf / gsettings default values"
echo

# MAIN System schemas: we have placed our override file in this directory
# Sending any "error" to null (if key not found don't want to worry user)
glib-compile-schemas /usr/share/glib-2.0/schemas/ > /dev/null 2>&1 || true;

# ------------------------------------------------------------------------------
# Finished
# ------------------------------------------------------------------------------
echo
echo "*** Script Exit: wasta-cinnamon-layout-postinst.sh"
echo

exit 0
