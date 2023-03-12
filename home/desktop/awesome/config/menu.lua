local awful = require("awful")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "term", terminal },
   { "keys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "man", terminal .. " -e man awesome" },
   { "reboot", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}