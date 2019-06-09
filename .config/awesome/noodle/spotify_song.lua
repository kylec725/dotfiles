-- NOTE:
-- This widget runs a script in the background
-- When awesome restarts, its process will remain alive!
-- Don't worry though! The cleanup script that runs in rc.lua takes care of it :)

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- pull in mpd_song.lua
local mpd_song = require("noodle.mpd_song")
local mpd_widget_children = mpd_song:get_all_children()
local mpd_title = mpd_widget_children[1]
local mpd_artist = mpd_widget_children[2]

-- Set colors
local title_color =  beautiful.mpd_song_title_color or beautiful.wibar_fg
local artist_color = beautiful.mpd_song_artist_color or beautiful.wibar_fg
local paused_color = beautiful.mpd_song_paused_color or beautiful.normal_fg

-- Set notification icon path
local notification_icon = beautiful.spotify_icon

local song_title = wibox.widget{
  text = "---------",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
}

local song_artist = wibox.widget{
  text = "---------",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
}

-- Title request
local title_request = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 title | grep variant"
local artist_request = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 artist | tail +3"
local song_request = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 -e title -e artist | sed -n -e '3p' -e '6p'"

-- spotify_song widget
local spotify_song = wibox.widget{
    song_title,
    song_artist,
    layout = wibox.layout.fixed.vertical
}

local artist_fg
local artist_bg
local spotify_title = "---------"
local spotify_artist = "---------"

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
            -- send notification on next song (if text field have changed)
            if (artist ~= spotify_artist and title ~= spotify_title and artist ~= nil) then
                send_notification(artist, title)
                spotify_artist = artist
                spotify_title = title
            end
            if spotify_bool then
                if (artist == nil) then
                    song_artist.text = "---------"
                    song_title.text = "---------"
                else
                    song_artist.text = artist
                    song_title.text = title
                end
            else
                song_artist.text = mpd_artist.text
                song_title.text = mpd_title.text
            end
        end
        )
end

update_widget()

local spotify_script = [[
  bash -c '
  ']]

spotify_song.songupdate = function()
    update_widget()
end

awful.widget.watch(spotify_script, 3, function(stdout)
    update_widget()
end, spotify_song)


return spotify_song
