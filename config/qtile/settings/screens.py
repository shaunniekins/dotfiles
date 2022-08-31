from libqtile import widget, bar, qtile
from libqtile.config import Screen
import os

from settings.theme import colors
from settings.keys import rofi_network, volume_mute, calendar, rofi_run

widget_defaults = dict(
    font = 'JetBrainsMono Nerd Font',   
    # font = 'Ubuntu',
    fontsize=10,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    borderwidth=0, 
                    active=colors[3], 
                    inactive=colors[2],
                    highlight_method = "block",
                    background=colors[0],
                    padding=5,
                ),
                widget.TextBox(
                    "🭀", 
                    fontsize=30,
                    foreground=colors[0], 
                    padding=0,
                ),
                widget.Prompt(
                    prompt=' </> ', 
                    background=colors[2],
                ),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox(
                    "", 
                    fontsize=40, 
                    background=colors[2], 
                    foreground=colors[0], 
                    padding=-9,
                ),
                widget.TextBox(
                    "", 
                    fontsize=40, 
                    background=colors[0], 
                    foreground=colors[2], 
                    padding=-9,
                ),
                widget.Wlan( 
                    background=colors[2],
                    update_interval=5,
                    mouse_callbacks = {
                        "Button1": lambda: qtile.cmd_spawn(rofi_network),
                    },
                    format = 'WIFI: {percent:2.0%}',
                    padding=10,
                ),
                widget.TextBox(
                    "", 
                    fontsize=40, 
                    background=colors[2], 
                    foreground=colors[0], 
                    padding=-9,
                ),
                widget.Battery(
                    background=colors[0],
                    charge_char='↑',
                    discharge_char='',
                    update_interval=1,
                    format='BATT: {char} {percent:2.0%}',
                    unknown_char = '?',
                    padding=10,
                ),
                widget.TextBox(
                    "", 
                    fontsize=40, 
                    background=colors[0], 
                    foreground=colors[2], 
                    padding=-9,
                ),
                widget.Volume(
                    background=colors[2],
                    fmt='VOL: {}',
                    mouse_callbacks={
                        'Button1': lambda: qtile.cmd_spawn(volume_mute),
                        'Button3': lambda: qtile.cmd_spawn("pavucontrol")
                    },
                    padding=10,
                ),
                widget.TextBox(
                    "", 
                    fontsize=40, 
                    background=colors[2], 
                    foreground=colors[0],
                    padding=-9,
                ),
                widget.Clock(
                    background=colors[0],
                    format='%H:%M %a %d %b ',
                    mouse_callbacks={
                        'Button3': lambda: qtile.cmd_spawn(calendar)
                    },
                    padding=10,
                ),
                widget.TextBox(
                    "", 
                    fontsize=40, 
                    background=colors[0], 
                    foreground=colors[2], 
                    padding=-9,
                ),
                widget.Systray(
                    icon_size = 15,
                    margin=3,
                ),
                widget.Notify(
                    padding=10,
                ),
                widget.Image(
                    filename='~/.config/qtile/arch-logo.png', 
                    margin=3, 
                    mouse_callbacks={
                        'Button1': 
                        lambda: qtile.cmd_spawn(rofi_run),
                        'Button3':
                        lambda: qtile.cmd_spawn(os.path.expanduser('~/.config/rofi/powermenu.sh')),
                    }
                ),
            ],
            # bar
            20,
            background = colors[2],
        ),
    ),
]