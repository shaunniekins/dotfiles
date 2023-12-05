from libqtile.config import Key
from libqtile.command import lazy

mod = "mod4"
mod_alt = "mod1"
terminal = "xfce4-terminal"
browser = "google-chrome"
file_manager = "pcmanfm"
screenshot = "flameshot gui"
# power_off = terminal + ' -e "shutdown -h now"' reboot
power_off = terminal + ' -e "systemctl poweroff"'
calendar = terminal + ' -e "cal -y"'
rofi_run = "rofi -show drun"
rofi_network = "bash \"./rofi-wifi-menu/rofi-wifi-menu.sh\""

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

    Key([mod, "shift"], "r", 
        lazy.reload_config(), 
        desc="Reload the config"),
    Key([mod, "control"], "q", 
        lazy.shutdown(), 
        desc="Shutdown Qtile / Log-out"),
    
    # Personal
    Key([mod], "d", 
        lazy.spawn(rofi_run),
        desc="Run Rofi"),
    Key([mod], "b", 
        lazy.spawn(browser), 
        desc="Run Browser"),
    Key([mod], "m", 
        lazy.spawn(file_manager), 
        desc="Run File Manager"),
    Key([mod, "shift"], "n", 
        lazy.spawn(rofi_network),
        desc="Run Network Manager"),
    Key([mod, "shift"], "y", 
        lazy.spawn(power_off),
        desc="Power Off Computer"),
    Key([mod, "shift"], "f",
        lazy.spawn(screenshot),
        desc="Run Flameshot"),
    
    # Adjust brightness
    Key([], "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set +10%"),
        desc="Brightness Up"),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 10%-"),
        desc="Brightness Down"),

    # Adjust volume
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -q set Master 10%+"),
        desc="Volume Up"),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("amixer -q set Master 10%-"),
        desc="Volume Down"),
    Key([], "XF86AudioMute",
        lazy.spawn("amixer -q set Master toggle"),
        desc="Volume Mute"),
    
    Key([mod, "shift"], "b",
        lazy.hide_show_bar(position='all'),
        desc="Toggle bars"),
]
