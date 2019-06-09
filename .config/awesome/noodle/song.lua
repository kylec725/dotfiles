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
local mpd_icon = beautiful.music_icon
local spotify_icon = beautiful.spotify_icon

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

local last_mpd_id
local function send_mpd_notification(artist, title)
  notification = naughty.notify({
      title = title,
      text = artist,
      icon = mpd_icon,
      position = "bottom_middle",
      replaces_id = last_mpd_id
  })
  last_mpd_id = notification.id
end

local last_spotify_id
local function send_spotify_notification(artist, title)
  notification = naughty.notify({
      title = title,
      text = artist,
      icon = spotify_icon,
      position = "bottom_middle",
      replaces_id = last_spotify_id
  })
  last_spotify_id = notification.id
end

-- mpd update
local mpd_title = "---------"
local mpd_artist = "---------"
local function mpd_update()
    -- awful.spawn.easy_async({"sh", "-c", "mpc"},
    awful.spawn.easy_async({"mpc", "-f", "[[%artist%@@%title%@]]"},
        function(stdout)
            local artist = stdout:match('(.*)@@')
            local title = stdout:match('@@(.*)@')
            if (artist == nil) then
                local mpd_title = "---------"
                local mpd_artist = "---------"
            else
                title = string.gsub(title, '^%s*(.-)%s*$', '%1')
                local status = stdout:match('%[(.*)%]')
                status = string.gsub(status, '^%s*(.-)%s*$', '%1')
                if (artist ~= mpd_artist and title ~= mpd_title) then
                    send_mpd_notification(artist, title)
                    mpd_artist = artist
                    mpd_title = title
                end
            end
        end
        )

end

local spotify_title = "---------"
local spotify_artist = "---------"
local function update_widget()
    -- update mpd title and artist
    mpd_update()
    -- extract artist and title
    awful.spawn.easy_async_with_shell(song_request, -- artist request
        function(stdout)
            local artist, title = stdout:match('string "(.+)"\n.*string "(.+)"')
            -- send notification on next song (if text field have changed)
            if (artist ~= spotify_artist and title ~= spotify_title and artist ~= nil) then
                send_spotify_notification(artist, title)
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
                song_artist.text = mpd_artist
                song_title.text = mpd_title
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
