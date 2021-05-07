#!/usr/bin/env sh

# current binary folder
export BIN_DIR=/run/current-system/sw/bin
# netowrk devices
export ETH_DEV=$(ip -o link show | $BIN_DIR/grep enp | $BIN_DIR/awk '{print $2}' | $BIN_DIR/head -1 | $BIN_DIR/cut -d":" -f1)
export WIFI_DEV=$($BIN_DIR/ip -o link show | $BIN_DIR/grep wlp | $BIN_DIR/awk '{print $2}' | $BIN_DIR/head -1 | $BIN_DIR/cut -d":" -f1)

# kill active bars
$BIN_DIR/pkill .polybar-wrappe
sleep 1

# primary display bar
for m in $($BIN_DIR/polybar --list-monitors | $BIN_DIR/grep primary | $BIN_DIR/cut -d":" -f1); do
  MONITOR=$m $BIN_DIR/polybar --reload mainbar -c /home/mrll/.config/polybar/config.ini &
done
# secondary display bar
for m in $($BIN_DIR/polybar --list-monitors | $BIN_DIR/grep -v primary | $BIN_DIR/cut -d":" -f1); do
  MONITOR=$m $BIN_DIR/polybar --reload sidebar -c /home/mrll/.config/polybar/config.ini &
done
