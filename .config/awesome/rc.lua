--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝


-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")


-- ===================================================================
-- User Configuration
-- ===================================================================


local themes = {
   "fireworks", -- 1
}

-- change this number to use the corresponding theme
local theme = themes[1]
local theme_config_dir = gears.filesystem.get_configuration_dir() .. "/configuration/" .. theme .. "/"

-- define default apps (global variable so other components can access it)
apps = {
   network_manager = "nm-connection-editor", -- recommended: nm-connection-editor
   power_manager = "", -- recommended: xfce4-power-manager
   terminal = "kitty",
   launcher = "rofi -normal-window -modi drun -show drun -theme " .. theme_config_dir .. "rofi.rasi",
   lock = "fade-lock",
   screenshot = "maim -u ~/pictures/screenshots/$(date +%s)-screenshot.png",
   selected_screenshot = "maim -so /tmp/maim_clipboard && xclip -selection clipboard -t image/png /tmp/maim_clipboard &> /dev/null && rm /tmp/maim_clipboard",
   browser = "firefox",
   private_browser = "firefox --private-window",
   filebrowser = "kitty lf",
   spotify = "spotify --force-device-scale-factor=1.5",
   mpd = "kitty -o window_padding_width=40 -o color3=#ffff8a -e ncmpcpp",
   zathura = "kitty -e pdf",
   top = "kitty -e gotop"
}

-- define wireless and ethernet interface names for the network widget
-- use `ip link` command to determine these
network_interfaces = {
   wlan = 'wlp2s0',
   lan = 'enp1s0'
}

-- List of apps to run on start-up
local run_on_start_up = {
   -- "picom --experimental-backends --backend 'glx' --config " .. theme_config_dir .. "picom.conf",
   "picom --experimental-backends --backend 'glx'",
   "redshift -c ~/.config/redshift/redshift.conf",
   "run x-on-resize -c ~/.bin/hdmi-toggle",
   "mpd",
   "libinput-gestures-setup start",
   "x-on-resize -c ~/.bin/hdmi-toggle",
   -- Set volume at 50%
   "amixer set Master unmute",
   "amixer set Master 50%"
}


-- ===================================================================
-- Initialization
-- ===================================================================


-- Import notification appearance
require("components.notifications")

-- Run all the apps listed in run_on_start_up
for _, app in ipairs(run_on_start_up) do
   local findme = app
   local firstspace = app:find(" ")
   if firstspace then
      findme = app:sub(0, firstspace - 1)
   end
   awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, app), false)
end

-- Import theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "-theme.lua")

-- Initialize theme
local selected_theme = require(theme)
selected_theme.initialize()


-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- Define layouts
awful.layout.layouts = {
   awful.layout.suit.spiral,
   awful.layout.suit.fullscreen,
}

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
   local current_layout = awful.tag.getproperty(t, 'layout')
   if (current_layout == awful.layout.suit.max) then
      t.gap = 0
   else
      t.gap = beautiful.useless_gap
   end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
   if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
end)


-- ===================================================================
-- Client Focusing
-- ===================================================================


-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
-- client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)


-- ===================================================================
-- Screen Change Functions (ie multi monitor)
-- ===================================================================


-- Reload config when screen geometry changes
screen.connect_signal("property::geometry", awesome.restart)


-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================


collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
