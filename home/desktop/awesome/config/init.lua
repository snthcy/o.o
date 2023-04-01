local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

-- defaults
terminal = "kitty"
browser = "firefox"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
shutdown = "systemctl poweroff"
reboot = "systemctl reboot"
modkey = "Mod4"

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image = beautiful.wallpaper,
                resize = false,
                widget = wibox.widget.imagebox
            },
            tiled = true,
            widget = wibox.container.tile
        }
    }
end)

require("config.binds")

require("config.main")

require("config.menu")

require("config.rules")