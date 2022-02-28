from typing import List  # noqa: F401

from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


colors = [["#800080", "#800080"],   #purple
          ["#0047ab", "#0047ab"],   #cobalt blue
          ["#000000", "#000000"],   #black
          ["#ffffff", "#ffffff"],   #white
          ["#404040", "#404040"],   #gray
          ["#ff0000", "#ff0000"],   #red
]

mod = "mod4"
terminal = "xfce4-terminal"
browser = "brave"
file_manager = "nemo"
screenshot = "flameshot gui"
network = "networkmanager_dmenu -nb '#000000' -nf '#ffffff' -sb '#0047ab' -sf '#ffffff'"
power_off = terminal + ' -e "shutdown -h now"'

keys = [
    # Switch between windows
    Key([mod], "h", 
        lazy.layout.left(), 
        desc="Move focus to left"),
    Key([mod], "l", 
        lazy.layout.right(), 
        desc="Move focus to right"),
    Key([mod], "j", 
        lazy.layout.down(), 
        desc="Move focus down"),
    Key([mod], "k", 
        lazy.layout.up(), 
        desc="Move focus up"),
    Key([mod], "space", 
        lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", 
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", 
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", 
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", 
        lazy.layout.shuffle_up(), 
        desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", 
        lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", 
        lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", 
        lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", 
        lazy.layout.grow_up(), 
        desc="Grow window up"),
    Key([mod], "n", 
        lazy.layout.normalize(), 
        desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", 
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", 
        lazy.spawn(terminal), 
        desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", 
        lazy.next_layout(), 
        desc="Toggle between layouts"),
    Key([mod], "w", 
        lazy.window.kill(), 
        desc="Kill focused window"),

    Key([mod, "control"], "r", 
        lazy.reload_config(), 
        desc="Reload the config"),
    Key([mod, "control"], "q", 
        lazy.shutdown(), 
        desc="Shutdown Qtile"),
    
    # Personal
    Key([mod], "d", 
        lazy.spawn("dmenu_extended_run"),
        #lazy.spawn("dmenu_run -nb '#000000' -nf '#ffffff' -sb '#800080' -sf '#ffffff'"), 
        desc="Run Dmenu"),
    Key([mod], "b", 
        lazy.spawn(browser), 
        desc="Run Browser"),
    Key([mod], "m", 
        lazy.spawn(file_manager), 
        desc="Run File Manager"),
    Key([mod, "shift"], "n", 
        lazy.spawn(network),
        desc="Run Network Manager Dmenu"),
    Key([mod, "shift"], "y", 
        lazy.spawn(power_off),
        desc="Power Off Computer"),
    Key([mod, "shift"], "f",
        lazy.spawn(screenshot),
        desc="Run Flameshot"),
    Key([], "F5", 
        lazy.spawn("brightnessctl s +5%"),
        desc="Brightness Up"),
    Key([], "F6",
        lazy.spawn("brightnessctl s 5%-"),
        desc="Brightness Down"),
    Key([], "F2",
        lazy.spawn("amixer -q set Master 10%+"),
        desc="Volume Up"),
    Key([], "F3",
        lazy.spawn("amixer -q set Master 10%-"),
        desc="Volume Down"),
    Key([], "F4",
        lazy.spawn("amixer -q set Master toggle"),
        desc="Volume Mute"),

]

groups = [
    Group("1", spawn = browser),
    Group("2",),
    Group("3"),
    Group("4"),
    Group("5"),
    ]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, 
            lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, 
            lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layouts = [
    layout.Columns(
        border_width=1,
        border_normal=colors[2],
        border_focus=colors[0],
        fair=True,
        margin=0,
        margin_on_single=0),
    layout.Max(),
]

widget_defaults = dict(
    font = 'Fira Code Nerd Font',
    #font = 'Computer Modern',
    #font = 'URW Gothic',
    #font='Hurmit Nerd Font Mono',
    fontsize=10,
    padding=1,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method = "line",
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(
                    icon_size = 14,
                ),
                widget.Notify(),
                widget.Sep(
                    padding=15,
                ),
                widget.Wlan( 
                    update_interval=5,
                    mouse_callbacks = {
                        "Button1": lambda: qtile.cmd_spawn(network),
                    },
                    format = 'Wifi: {essid} - {percent:2.0%}',
                ),
                widget.Sep(
                    padding=15,
                ),
                widget.Battery(
                    charge_char='↑',
                    discharge_char='',
                    update_interval=1,
                    format='Batt: {char} {percent:2.0%}',
                    unknown_char = '?',
                ),
                widget.Sep(
                    padding=15,
                ),
                widget.TextBox(
                    fmt = 'Vol:',
                    mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
                ),
                widget.Volume(
                    mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
                ),
                widget.Sep(
                    padding=15,
                ),
                widget.Clock(
                    format='%a %d %b - %H:%M',
                ),
                widget.Sep(
                    linewidth = 0,
                    padding=10,
                ),
            ],
            20,
            background = colors[2],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

import os
import subprocess, re

@hook.subscribe.startup
def autostart():
    processes = [
        ['flameshot'],
        ['dunst'],
    ]

    for p in processes:
        subprocess.Popen(p)

wmname = "LG3D"
