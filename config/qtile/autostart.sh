#!/bin/sh
intern=LVDS-1
extern=VGA-1

# "$extern"
# "$intern"


if xrandr | grep "$extern connected"; then
  # xrandr --output "$extern" --off --output "$intern" --auto

  xrandr --output "$intern" --off --output "$extern" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off --output HDMI-3 --off --output DP-2 --off --output DP-3 --off
else
  xrandr --output "$extern" --off --output "$intern" --auto
fi
