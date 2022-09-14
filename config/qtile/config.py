import os
from typing import List  # noqa: F401

from libqtile import hook

from settings.keys import mod, keys
from settings.groups import groups
from settings.layouts import layouts
from settings.screens import screens, widget_defaults, extension_defaults


dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"

import subprocess

@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])
    
    processes = [
        ['flameshot'],
        ['dunst'],
    ]
    for p in processes:
        subprocess.Popen(p)