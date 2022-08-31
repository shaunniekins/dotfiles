from libqtile.config import Key, Group
from libqtile.command import lazy

from settings.keys import mod, keys, browser

groups = [
    Group("1", spawn = browser),
    Group("2",),
    ]

for i in groups:
    keys.extend([
        Key([mod], i.name, 
            lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        Key([mod, "shift"], i.name, 
            lazy.window.togroup(i.name, switch_group=False),
            # lazy.window.togroup(i.name),
            desc="Switch to & move focused window to group {}".format(i.name)),
    ])