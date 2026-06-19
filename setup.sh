#!/bin/sh
set -e

# Fedora defaults enable the Plasma virtual keyboard daemon, which breaks key
# repeat on Wayland. Pointing InputMethod to /dev/null prevents it from
# starting without disabling input entirely.
echo "==> Disabling plasma-keyboard (fixes key repeat on Wayland)..."
kwriteconfig6 --file kwinrc --group Wayland --key InputMethod '/dev/null'

# By default, screen-edge triggers (e.g. bottom-left corner → Show Desktop)
# fire on every monitor. This restricts them to the primary display only.
echo "==> Restricting screen-edge actions to the primary monitor..."
kwriteconfig6 --file kwinrc --group Windows --key ElectricBorderAllScreenCorner false

echo "==> Setup complete. Log out and back in for changes to take effect."
