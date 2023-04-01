local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

awful.keyboard.append_global_keybindings({
    -- general keybindings
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal) end,
              { description = "open a terminal", group = "launcher" }),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
              { description = "reload awesome", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "q", awesome.quit,
              { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
              { description="show help", group="awesome" }),

    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
              { description = "run prompt", group = "launcher" }),

    -- !! TODO: Look into this
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --           {description = "show main menu", group = "awesome"}),


    -- -- utility
    -- awful.key({ modkey }, "Print Scrn", function () awful.spawn.with_shell("~/.config/awesome/bin/screenshot full") end,
    --     { description = "full screen", group = "screenshot" }),

	-- awful.key({ modkey, "Shift" }, "Print Scrn", function () awful.spawn.with_shell("~/.config/awesome/bin/screenshot region") end,
    --     { description = "screen region", group = "screenshot" }),

    awful.key({ }, "XF86AudioRaiseVolume", function () 
			awful.spawn.with_shell("pamixer -i 3")
			--awesome.emit_signal("widget::volume")
		end,
        { description = "raise volume", group = "volume" }),

    -- !! TODO: audio keys and widgets
    awful.key({ }, "XF86AudioLowerVolume", function () 
			awful.spawn.with_shell("pamixer -d 3")
			--awesome.emit_signal("widget::volume")
		end,
        { description = "lower volume", group = "volume" }),

    awful.key({ }, "XF86AudioMute", function () 
			awful.spawn.with_shell("pamixer -t")
			--awesome.emit_signal("widget::volume")
		end,
        { description = "mute volume", group = "volume" }),

    awful.key({ }, "XF86AudioPlay", function() 
        awful.spawn("playerctl play-pause") 
        end,
        { description = "toggle playerctl", group = "awesome" }),

    awful.key({ }, "XF86AudioPrev", function() 
        awful.spawn("playerctl previous") 
        end,
        { description = "playerctl previous", group = "awesome" }),

    awful.key({ }, "XF86AudioNext", function() 
        awful.spawn("playerctl next") 
        end,
        { description = "playerctl next", group = "awesome" }),

	awful.key({ }, "XF86MonBrightnessUp", function () 
			awful.spawn.with_shell("brightnessctl set +5%")
			--awesome.emit_signal("widget::brightness")
		end,
        { description = "raise brightness", group = "brightness" }),
        
	awful.key(
		{ }, "XF86MonBrightnessDown", function () 
			awful.spawn.with_shell("brightnessctl set 5%-")
			--awesome.emit_signal("widget::brightness")
		end,
        { description = "lower brightness", group = "brightness" }
	),


    -- tags
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },

    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
					tag:view_only()
                end
            end
        end,
    }

    awful.key({ modkey, }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),


    awful.key({ modkey, }, "Left", awful.tag.viewprev,
              { description = "view previous", group = "tag" }),

    awful.key({ modkey, }, "Right", awful.tag.viewnext,
              { description = "view next", group = "tag" }),

    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
              { description = "go back", group = "tag" }),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
})


-- mouse bindings
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
		-- Focus
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
		-- Move
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
		-- Resize
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)


-- client bindings
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
    awful.key({ modkey, }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),

    awful.key({ modkey, "Shift" }, "c", 
        function (c) c:kill() end,
        { description = "close", group = "client" }),

    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle ,
              { description = "toggle floating", group = "client" }),

    awful.key({ modkey, }, "t", 
        function (c) c.ontop = not c.ontop end,
              { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey, }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        { description = "toggle maximize", group = "client" }),
}))