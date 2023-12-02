-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox") 
local battery = require("lain/widget/bat")
-- Theme handling library
local beautiful = require("beautiful")
local lain = require("lain")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local newtwork_manager_widget = require("network-manager-widget.netmgr")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local vicious = require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
        naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
        local in_error = false
        awesome.connect_signal("debug::error", function (err)
                -- Make sure we don't go into an endless error loop
                if in_error then return end
                in_error = true

                naughty.notify({ preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = tostring(err) })
                in_error = false
        end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/nord/theme.lua")
local wallpaper_path = "/home/noaoh/Pictures/wallpapers/"
beautiful.wallpaper = wallpaper_path.."wallhaven-288gj9-blue.png"

local currently_listening_widget = require("currently-listening-widget")


terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
        awful.layout.suit.floating,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
        -- awful.layout.suit.corner.ne,
        -- awful.layout.suit.corner.sw,
        -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
        local instance = nil

        return function ()
                if instance and instance.wibox.visible then
                        instance:hide()
                        instance = nil
                else
                        instance = awful.menu.clients({ theme = { width = 250 } }) end
                end
        end
        -- }}}

        -- {{{ Menu
        -- Create a launcher widget and a main menu
        myawesomemenu = {
                { "hotkeys", function() return false, hotkeys_popup.show_help end},
                { "manual", terminal .. " -e man awesome" },
                { "edit config", editor_cmd .. " " .. awesome.conffile },
                { "restart", awesome.restart },
                { "quit", function() awesome.quit() end}
        }

        mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
}
                        })

                        mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                        menu = mymainmenu })

                        -- Menubar configuration
                        menubar.utils.terminal = terminal -- Set the terminal for applications that require it
                        -- }}}

                        -- Keyboard map indicator and switcher
                        mykeyboardlayout = awful.widget.keyboardlayout()


                        -- {{{ Wibar
                        -- Create a textclock widget
                        local mytextclock = wibox.widget.textclock("%a %Y-%m-%d %H:%M %Z ")

                        -- Create a battery indicator
                        local mybattery = lain.widget.bat {
                                settings = function() 
                                        widget:set_markup("<span foreground='#A3BE8C'>Bat: " .. bat_now.perc .. "% </span>> ")
                                end
                        }

                        -- Create a CPU indicator
                        local mycpu = lain.widget.cpu {
                                settings = function()
                                        widget:set_markup("<span foreground='#BF616A'>CPU: " .. cpu_now.usage .. "% </span>> ")
                                end
                        }

                        -- Create a memory indicator
                        local mymem = lain.widget.mem {
                                settings = function()
                                        widget:set_markup("<span foreground='#EBCB8B'>Mem: " .. mem_now.perc .. "% </span>> ")
                                end
                        }

                        local quake = lain.util.quake({ 
                                app = "urxvt",
                                vert = "top",
                                sticky = true,
                                height = 0.4,
                        })

                        function mynetworkmenu()
                                networkmenu = awful.menu({
                                items = network_manager_widget.generate_network_menu()
                            })
                                return networkmenu
                            end
                            
                        mynetworklauncher = awful.widget.launcher({
                            menu = awful.menu({ 
                                items = {{ "s" , "s" }, { "s" , "s" }}
                            })
                        })
                            
                        function updatenetworkmenu()
                                mynetworklauncher = awful.widget.launcher({
                                                    menu = mynetworkmenu()
                            })
                                return mynetworklauncher
                        end
    			
                        -- updatenetworkmenu()
                        -- vicious.register(mynetworklauncher, awful.widget.launcher, updatenetworkmenu(), 30 )

                        -- Create a wibox for each screen and add it
                        local taglist_buttons = gears.table.join(
                        awful.button({ }, 1, function(t) t:view_only() end),
                        awful.button({ modkey }, 1, function(t)
                                if client.focus then
                                        client.focus:move_to_tag(t)
                                end
                        end),
                        awful.button({ }, 3, awful.tag.viewtoggle),
                        awful.button({ modkey }, 3, function(t)
                                if client.focus then
                                        client.focus:toggle_tag(t)
                                end
                        end),
                        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                        )

                        local tasklist_buttons = gears.table.join(
                        awful.button({ }, 1, function (c)
                                if c == client.focus then
                                        c.minimized = true
                                else
                                        -- Without this, the following
                                        -- :isvisible() makes no sense
                                        c.minimized = false

                                                c.first_tag:view_only()
                                        end
                                        -- This will also un-minimize
                                        -- the client, if needed
                                        client.focus = c
                                        c:raise()
                                
                        end),
                        awful.button({ }, 3, client_menu_toggle_fn()),
                        awful.button({ }, 4, function ()
                                awful.client.focus.byidx(1)
                        end),
                        awful.button({ }, 5, function ()
                                awful.client.focus.byidx(-1)
                        end))

                        local function set_wallpaper(s)
                                -- Wallpaper
                                if beautiful.wallpaper then
                                        local wallpaper = beautiful.wallpaper
                                        io.write(wallpaper)
                                        -- If wallpaper is a function, call it with the screen
                                        if type(wallpaper) == "function" then
                                                wallpaper = wallpaper(s)
                                        end
                                        gears.wallpaper.maximized(wallpaper, s, true)
                                end
                        end

                        -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
                        screen.connect_signal("property::geometry", set_wallpaper)

                        awful.screen.connect_for_each_screen(function(s)
                                -- Wallpaper
                                set_wallpaper(s)

                                -- Each screen has its own tag table.
                                awful.tag(
                                    { "\u{eb01}", "\u{eac4}", "\u{f001}", "\u{f151f}", "\u{f1064}", "\u{ead8}", "\u{f27a}", "\u{f0508}" },
                                    s,
                                    awful.layout.layouts[1]
                                )

                                -- Create a promptbox for each screen
                                s.mypromptbox = awful.widget.prompt()
                                -- Create an imagebox widget which will contain an icon indicating which layout we're using.
                                -- We need one layoutbox per screen.
                                s.mylayoutbox = awful.widget.layoutbox(s)
                                s.mylayoutbox:buttons(gears.table.join(
                                awful.button({ }, 1, function () awful.layout.inc( 1) end),
                                awful.button({ }, 3, function () awful.layout.inc(-1) end),
                                awful.button({ }, 4, function () awful.layout.inc( 1) end),
                                awful.button({ }, 5, function () awful.layout.inc(-1) end)))
                                -- Create a taglist widget
                                s.mytaglist = awful.widget.taglist {
                                    screen = s,
                                    filter = awful.widget.taglist.filter.all,
                                    style = {
                                        shape = gears.shape.powerline,
                                        font = "Inconsolata Nerd Font Mono 24",
                                    },
                                    layout = {
                                        spacing = 18,
                                        spacing_widget = {
                                            color  = '#dddddd',
                                            shape  = gears.shape.powerline,
                                            widget = wibox.widget.separator,
                                        },
                                        layout  = wibox.layout.fixed.horizontal
                                    },
                                    widget_template = {
                                        {
                                            {
                                                {
                                                    {
                                                        id = 'icon_role',
                                                        widget = wibox.widget.imagebox,
                                                    },
                                                    margins = 0,
                                                    widget = wibox.container.margin,
                                                },
                                                {
                                                    id = 'text_role',
                                                    widget = wibox.widget.textbox,
                                                },
                                                layout = wibox.layout.fixed.horizontal,
                                                },
                                                left  = 8,
                                                right = 8,
                                                widget = wibox.container.margin
                                        },
                                        id = 'background_role',
                                        widget = wibox.container.background,
                                    },
                                    buttons = taglist_buttons
                                }
                                -- Create a tasklist widget
                                s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

                                -- Create the wibox
                                s.mywibox = awful.wibar({ position = "top", screen = s })


                                -- Add widgets to the wibox
                                s.mywibox:setup {
                                        layout = wibox.layout.align.horizontal,
                                        { -- Left widgets
                                                layout = wibox.layout.fixed.horizontal,
                                                s.mytaglist,
                                        },
                                        {
                                                layout = wibox.layout.flex.horizontal,
                                                currently_listening_widget,
                                        },
                                        { -- Right widgets
                                                layout = wibox.layout.fixed.horizontal,
                                                mybattery,
                                                mycpu,
                                                mymem,
                                                mytextclock,
                                                s.mylayoutbox,
                                        },
                }
        end)
        -- }}}

        -- {{{ Mouse bindings
        root.buttons(gears.table.join(
        awful.button({ }, 3, function () mymainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
        ))
        -- }}}

        local lockscreen_wallpaper_path = "/home/noaoh/Pictures/wallpapers/nightdesktop1.png"
        -- {{{ Key bindings
        globalkeys = gears.table.join(
        awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
        awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
        awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),
        awful.key({ modkey, }, "`", function() quake:toggle() end),
        awful.key({ modkey, "Shift" }, "l", function() awful.util.spawn("i3lock -i " .. lockscreen_wallpaper_path) end),
        awful.key({ modkey, }, "j",
        function()
                awful.client.focus.bydirection("down")
                if client.focus then client.focus:raise() end
        end),
        awful.key({ modkey }, "k",
        function()
                awful.client.focus.bydirection("up")
                if client.focus then client.focus:raise() end
        end),
        awful.key({ modkey }, "h",
        function()
                awful.client.focus.bydirection("left")
                if client.focus then client.focus:raise() end
        end),
        awful.key({ modkey }, "l",
        function()
                awful.client.focus.bydirection("right")
                if client.focus then client.focus:raise() end
        end),
        -- awful.key({ modkey,           }, "j",
        -- function ()
        --        awful.client.focus.bydirection("down") --byidx(1)
        -- end,
        -- {description = "focus next by index", group = "client"}
        -- ),
        -- awful.key({ modkey,           }, "k",
        -- function ()
        --        awful.client.focus.byidx("down") --byidx(-1)
        -- end,
        -- {description = "focus previous by index", group = "client"}
        -- ),
        -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
        --          {description = "show main menu", group = "awesome"}),

        -- Layout manipulation
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"}),
        awful.key({ modkey, "Control" }, "h", function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
        awful.key({ modkey, "Control" }, "l", function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),
        awful.key({ modkey,           }, "Tab",
        function ()
                awful.client.focus.history.previous()
                if client.focus then
                        client.focus:raise()
                end
        end,
        {description = "go back", group = "client"}),

        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
        awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
        awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

        -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
        -- {description = "increase master width factor", group = "layout"}),
        -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
        -- {description = "decrease master width factor", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
        awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}),
        awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}),
        awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
        {description = "select next", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
        {description = "select previous", group = "layout"}),

        awful.key({ modkey, "Control" }, "n",
        function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                        client.focus = c
                        c:raise()
                end
        end,
        {description = "restore minimized", group = "client"}),

        -- Prompt
        awful.key({ modkey },            "r",     function () os.execute("rofi -show combi") end,
                {description = "run prompt", group = "launcher"}),

        awful.key({ modkey }, "x",
        function ()
                awful.prompt.run {
                        prompt       = "Run Lua code: ",
                        textbox      = awful.screen.focused().mypromptbox.widget,
                        exe_callback = awful.util.eval,
                        history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
        end,
        {description = "lua execute prompt", group = "awesome"}),
        -- Menubar
        awful.key({ modkey }, "p", function() menubar.show() end,
        {description = "show the menubar", group = "launcher"})
        )

        clientkeys = gears.table.join(
        awful.key({ modkey,           }, "f",
        function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
        {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
        {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
        {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
        function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
        function (c)
                c.maximized = not c.maximized
                c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
        function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
        function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
        awful.key({ modkey, "Shift" }, "n", 
        function () 
                lain.util.add_tag(mylayout) 
        end),
        awful.key({ modkey, "Shift" }, "r", 
        function () 
                lain.util.rename_tag() 
        end),
        awful.key({ modkey, "Shift" }, "Left", 
        function () 
                lain.util.move_tag(1) 
        end),   -- move to next tag
        awful.key({ modkey, "Shift" }, "Right", 
        function () 
                lain.util.move_tag(-1) 
        end) -- move to previous tag
        -- awful.key({ modkey, "Shift" }, "d", 
        -- function () lain.util.
        -- end)
        )

        -- Bind all key numbers to tags.
        -- Be careful: we use keycodes to make it work on any keyboard layout.
        -- This should map on the top row of your keyboard, usually 1 to 9.
        local tags_end = 9
        for i = 1, tags_end do
                -- naughty.notify({ text = "i: " .. i })
                -- naughty.notify({ text = "i + tags_end: " .. i + tags_end })
                globalkeys = gears.table.join(globalkeys,
                -- View tag only.
                awful.key({ modkey }, "#" .. i + tags_end,
                function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                                tag:view_only()
                        end
                end,
                {description = "view tag #"..i, group = "tag"}),
                -- Toggle tag display.
                awful.key({ modkey, "Control" }, "#" .. i + tags_end,
                function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                                awful.tag.viewtoggle(tag)
                        end
                end,
                {description = "toggle tag #" .. i, group = "tag"}),
                -- Move client to tag.
                awful.key({ modkey, "Shift" }, "#" .. i + tags_end,
                function ()
                        if client.focus then
                                local tag = client.focus.screen.tags[i]
                                if tag then
                                        client.focus:move_to_tag(tag)
                                end
                        end
                end,
                {description = "move focused client to tag #"..i, group = "tag"}),
                -- Toggle tag on focused client.
                awful.key({ modkey, "Control", "Shift" }, "#" .. i + tags_end,
                function ()
                        if client.focus then
                                local tag = client.focus.screen.tags[i]
                                if tag then
                                        client.focus:toggle_tag(tag)
                                end
                        end
                end,
                {description = "toggle focused client on tag #" .. i, group = "tag"})
                )
        end

        clientbuttons = gears.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize))

        -- Set keys
        root.keys(globalkeys)
        -- }}}

        -- {{{ Rules
        -- Rules to apply to new clients (through the "manage" signal).
        awful.rules.rules = {
                -- All clients will match this rule.
                { rule = { },
                properties = { border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
},

-- Floating clients.
{ rule_any = {
        instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
        },
        class = {
                "Arandr",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Wpa_gui",
                "pinentry",
                "veromix",
                "xtightvncviewer"},

                name = {
                        "Event Tester",  -- xev.
                },
                role = {
                        "AlarmWindow",  -- Thunderbird's calendar.
                        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
                }
        }, properties = { floating = true }},

        -- Add titlebars to normal clients and dialogs
        { rule_any = {type = { "normal", "dialog" }
}, properties = { titlebars_enabled = false }
    },
    { rule = { class = "Firefox" }, properties = { opacity = 1, maximized = false, floating = false } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and
                not c.size_hints.user_position
                and not c.size_hints.program_position then
                -- Prevent clients from being unreachable after screen count changes.
                awful.placement.no_offscreen(c)
        end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
        awful.button({ }, 1, function()
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
                client.focus = c
                c:raise()
                awful.mouse.client.resize(c)
        end)
        )

        awful.titlebar(c) : setup {
                { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
        { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
},
buttons = buttons,
layout  = wibox.layout.flex.horizontal
        },
        { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
},
layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                and awful.client.focus.filter(c) then
                client.focus = c
        end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
