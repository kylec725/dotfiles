-- Key Configuration

local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

local helpers = require("helpers")

-- Requirements so widgets can be updated
local brightness_bar = require("noodle.brightness_bar")
local mpd_song = require("noodle.mpd_song")

local keys = {}

-- Set modifier key
modkey = "Mod1"

keys.globalkeys = gears.table.join(
    -- Client navigation
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- main menu
    -- awful.key({ modkey, "Shift"   }, "m", function () mymainmenu:show() end,
    --           {description = "show main menu", group = "awesome"}),

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
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Launch programs
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "r",       function () awful.spawn(filemanager) end,
        {description = "open ranger file manager", group = "launcher"}),
    awful.key({ modkey,           }, "w",       function () awful.spawn(browser) end,
        {description = "open firefox", group = "launcher"}),
    awful.key({ modkey,           }, "d",       function () awful.spawn.with_shell(launcher) end,
        {description = "open rofi", group = "launcher"}),
    awful.key({ modkey,           }, "s",       function () awful.spawn(spotify) end,
        {description = "open spotify", group = "launcher"}),
    awful.key({ modkey,           }, "p",       function () awful.spawn(python) end,
        {description = "open python", group = "launcher"}),
    awful.key({ modkey,           }, "v",       function () awful.spawn(vlc) end,
        {description = "open vlc", group = "launcher"}),
    awful.key({ modkey,           }, "z", -- have the pdf script spawn in a floating window
        function () awful.spawn(pdf,{
                    -- floating = true,
                    -- placement = awful.placement.centered,
                    -- width = 1200,
                    -- height = 1000,
                    fullscreen = true
            }) end,
        {description = "open pdf viewer", group = "launcher"}),
    awful.key({}, "Print", function ()
        awful.spawn.with_shell(scrot)
        naughty.notify({
            text = "Screenshot Taken",
            title = "Scrot",
            icon = "/home/kyle/.config/awesome/themes/skyfall/icons/screenshot.png",
            position = "bottom_middle",
        })
    end,
    {description = "take a screenshot with scrot", group = "launcher"}),

    -- Volume control
    awful.key({}, "XF86AudioRaiseVolume",       function () awful.spawn.with_shell("amixer -D pulse sset Master 5%+") end,
        {description = "increase volume by 5%", group = "launcher"}),
    awful.key({}, "XF86AudioLowerVolume",       function () awful.spawn.with_shell("amixer -D pulse sset Master 5%-") end,
        {description = "decrease volume by 5%", group = "launcher"}),
    awful.key({}, "XF86AudioMute",              function ()awful.spawn.with_shell("amixer -q sset Master,0 toggle") end,
        {description = "toggle volume mute", group = "launcher"}),

    -- Spotify control
    awful.key({}, "XF86AudioPlay",       function ()
        awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
    end, {description = "play or pause spotify", group = "launcher"}),
    awful.key({}, "XF86AudioNext",       function ()
        awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
        mpd_song.update()
    end, {description = "next song in spotify", group = "launcher"}),
    awful.key({}, "XF86AudioPrev",       function ()
        awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
        mpd_song.update()
    end, {description = "previous song in spotify", group = "launcher"}),
    awful.key({ modkey,           }, "l",     function ()
        awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
        mpd_song.update()
    end, {description = "next song in spotify", group = "layout"}),
    awful.key({ modkey,           }, "h",     function ()
        awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
        mpd_song.update()
    end, {description = "previous song in spotify", group = "layout"}),

    -- Screen brightness control
    awful.key({}, "XF86MonBrightnessUp",       function ()
        awful.spawn.with_shell("light -A 5")
        brightness_bar.update()
    end,
        {description = "increase brightness by 5%", group = "launcher"}),
    awful.key({}, "XF86MonBrightnessDown",       function ()
        awful.spawn.with_shell("light -U 5")
        brightness_bar.update()
    end,
        {description = "decrease brightness by 5%", group = "launcher"}),

    -- Lock control
    awful.key({modkey, "Shift"}, "p", function ()
        local tmp = os.execute("pgrep xss-lock > tmp")
        file = io.open("tmp")
        io.input(file)
        lock_pid = io.read()
        io.close(file)
        if lock_pid == nil or lock_pid == "" then
            awful.spawn.with_shell("xss-lock -l fade-lock +resetsaver &")
            naughty.notify({
                text = "Lock On",
                icon = "/home/kyle/.config/awesome/themes/skyfall/icons/lock.png",
                bg = "#F1FCF9",
                fg = "#20262C",
                position = "bottom_middle",
            })
        else
            awful.spawn.with_shell("killall xss-lock")
            naughty.notify({
                text = "Lock Off",
                icon = "/home/kyle/.config/awesome/themes/skyfall/icons/lock.png",
                position = "bottom_middle",
            })
        end
        os.remove("tmp")
    end,
    {description = "toggle auto lock", group = "launcher"}),
    awful.key({modkey, "Shift"}, "semicolon",       function () awful.spawn.with_shell("fade-lock") end,
        {description = "fade-lock", group = "launcher"}),

    -- Restart and quit bindings
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,         }, "Escape",
        function ()
            sidebar.visible = false
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}),

    -- Toggle sidebar
    awful.key({ modkey }, "semicolon", function() sidebar.visible = not sidebar.visible end,
              {description = "show or hide sidebar", group = "awesome"}),
    awful.key({}, "Escape", function() sidebar.visible = false end,
              {description = "hide sidebar", group = "awesome"}),

    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --     {description = "increase master width factor", group = "layout"}),
    -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --     {description = "decrease master width factor", group = "layout"}),
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
              {description = "select previous", group = "layout"})

    -- Prompt
    -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    --           {description = "run prompt", group = "launcher"}),

    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run {
    --                 prompt       = "Run Lua code: ",
    --                 textbox      = awful.screen.focused().mypromptbox.widget,
    --                 exe_callback = awful.util.eval,
    --                 history_path = awful.util.get_cache_dir() .. "/history_eval"
    --               }
    --           end,
    --           {description = "lua execute prompt", group = "awesome"})
    -- Menubar
    -- awful.key({ modkey, "Shift" }, "p", function() menubar.show() end,
    --           {description = "show the menubar", group = "launcher"})
)

keys.clientkeys = gears.table.join(
    -- awful.key({ modkey,           }, "f",
    --     function (c)
    --         c.fullscreen = not c.fullscreen
    --         c:raise()
    --     end,
    --     {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey,           }, "m", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.maximized = not c.maximized
            if c.maximized then
                c.border_width = 0
            else
                c.border_width = beautiful.border_width
            end
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = 10
for i = 1, ntags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
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
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
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

keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        sidebar.visible = false
    end),
    awful.button({ modkey }, 2, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end),
    awful.button({}, 2, function (c)
        -- c:emit_signal("request::activate", "mouse_click", {raise = true})
        sidebar.visible = not sidebar.visible
    end)
)

keys.desktopbuttons = gears.table.join(
    awful.button({ }, 1, function ()
        mymainmenu:hide()
        sidebar.visible = false
        naughty.destroy_all_notifications()

        local function double_tap()
          uc = awful.client.urgent.get()
          -- If there is no urgent client, go back to last tag
          if uc == nil then
            awful.tag.history.restore()
          else
            awful.client.urgent.jumpto()
          end
        end
        helpers.single_double_tap(function() end, double_tap)
    end),
    awful.button({ }, 2, function ()
        sidebar.visible = not sidebar.visible
    end),
    awful.button({ }, 3, function ()
        mymainmenu:toggle()
        -- sidebar.visible = not sidebar.visible
    end),

    -- Middle button - Toggle start scren
-- {{{ Mouse bindings
root.buttons(gears.table.join(
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)),
-- }}}

    -- Scrolling - Switch tags
    -- awful.button({ }, 4, awful.tag.viewprev),
    -- awful.button({ }, 5, awful.tag.viewnext),

    -- Side buttons - Control volume
    awful.button({ }, 9, function () awful.spawn.with_shell("volume-control.sh up") end),
    awful.button({ }, 8, function () awful.spawn.with_shell("volume-control.sh down") end)

    -- Side buttons - Minimize and restore minimized client
    -- awful.button({ }, 8, function()
    --     if client.focus ~= nil then
    --         client.focus.minimized = true
    --     end
    -- end),
    -- awful.button({ }, 9, function()
    --       local c = awful.client.restore()
    --       -- Focus restored client
    --       if c then
    --           client.focus = c
    --           c:raise()
    --       end
    -- end)
)

-- Set keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
