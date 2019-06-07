-- NOTE:
-- This widget runs a script in the background
-- When awesome restarts, its process will remain alive!
-- Don't worry though! The cleanup script that runs in rc.lua takes care of it :)

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Set colors
local title_color =  beautiful.mpd_song_title_color or beautiful.wibar_fg
local artist_color = beautiful.mpd_song_artist_color or beautiful.wibar_fg
local paused_color = beautiful.mpd_song_paused_color or beautiful.normal_fg

-- Set notification icon path
local notification_icon = beautiful.music_icon

local mpd_title = wibox.widget{
  text = "---------",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
}

local mpd_artist = wibox.widget{
  text = "---------",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
}

-- Title request
local title_request = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 title | grep variant"
local artist_request = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 artist | tail +3"
local song_request = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 -e title -e artist | sed -n -e '3p' -e '6p'"

-- Main widget
local mpd_song = wibox.widget{
  mpd_title,
  mpd_artist,
  layout = wibox.layout.fixed.vertical
}

-- Mouse control
-- mpd_song:buttons(gears.table.join(
--     -- 
--     awful.button({ }, 1, function ()
--     end),
--     -- 
--     awful.button({ }, 2, function () 
--     end),
--     -- 
--     awful.button({ }, 3, function () 
--     end),
--     -- 
--     awful.button({ }, 4, function () 
--     end),
--     awful.button({ }, 5, function () 
--     end)
-- ))

local artist_fg
local artist_bg

local last_notification_id
local function send_notification(artist, title)
  notification = naughty.notify({
      -- title = "Now playing:",
      -- text = title .. " -- " .. artist,
      title = title,
      text = artist,
      icon = notification_icon,
      -- width = 360,
      -- height = 90,
      -- icon_size = 60,
      -- timeout = 4,
      position = "bottom_middle",
      replaces_id = last_notification_id
  })
  last_notification_id = notification.id
end

local function update_widget()
    -- extract artist and title
    awful.spawn.easy_async_with_shell(song_request, -- artist request
        function(stdout)
            local artist, title = stdout:match('string "(.+)"\n.*string "(.+)"')
            if (artist == nil) then
                mpd_artist.text = "---------"
            end
            if (title == nil) then
                mpd_title.text = "---------"
            else
                -- send notification on next song (if text field have changed)
                if (artist ~= mpd_artist.text and title ~= mpd_title.text) then
                    send_notification(artist, title)
                end
                mpd_artist.text = artist
                mpd_title.text = title
            end
        end
        )
end

-- Signals
-- mpd_song:connect_signal("mouse::enter", function ()
--     blablabla()
-- end)

update_widget()

local mpd_script = [[
  bash -c '
  ']]

mpd_song.songupdate = function()
    update_widget()
end

-- awful.spawn.with_line_callback(mpd_script, {
--                                  stdout = function(line)
--                                    -- naughty.notify { text = "LINE:"..line }
--                                    update_widget()
--                                  end
-- })
awful.widget.watch(mpd_script, 3, function(stdout)
    update_widget()
end, mpd_song)


return mpd_song
