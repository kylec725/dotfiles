-- NOTE:
-- This widget runs a script in the background
-- When awesome restarts, its process will remain alive!
-- Don't worry though! The cleanup script that runs in rc.lua takes care of it :)

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local naughty = require("naughty")
local dpi = xresources.apply_dpi

-- Set colors
local active_color = beautiful.volume_bar_active_color or "#5AA3CC"
local muted_color = beautiful.volume_bar_muted_color or "#666666"
local active_background_color = beautiful.volume_bar_active_background_color or "#222222"
local muted_background_color = beautiful.volume_bar_muted_background_color or "#222222"
local hover_color = "#546577"
local hover_muted_color = "#abfeff"

local volume_bar = wibox.widget{
    max_value     = 100,
    value         = 50,
    forced_height = dpi(10),
    margins       = {
        top = dpi(8),
        bottom = dpi(8),
    },
    forced_width  = dpi(200),
    shape         = gears.shape.rounded_bar,
    bar_shape     = gears.shape.rounded_bar,
    color         = active_color,
    background_color = active_background_color,
    border_width  = 0,
    border_color  = beautiful.border_color,
    widget        = wibox.widget.progressbar,
}

local is_muted = false
local hover = false
local vol_id = nil

local function update_widget()
    awful.spawn.easy_async({"sh", "-c", "pactl list sinks"},
        function(stdout)
            local volume = stdout:match('(%d+)%% /')
            local muted = stdout:match('Mute:(%s+)[yes]')
            local fill_color
            local bg_color
            if muted ~= nil then
                vol_id = naughty.notify({
                        text = "Muted",
                        icon = beautiful.muted_icon,
                        timeout = 2,
                        position = "bottom_middle",
                        replaces_id = vol_id
                    }).id
                if hover then
                    fill_color = "#546577" 
                else
                    fill_color = muted_color
                end
                bg_color = muted_background_color
                is_muted = true
            else
                vol_id = naughty.notify({
                        text = volume,
                        icon = beautiful.volume_icon,
                        timeout = 2,
                        position = "bottom_middle",
                        replaces_id = vol_id
                    }).id
                if hover then
                    fill_color = "#abfeff"
                else
                    fill_color = active_color
                end
                bg_color = active_background_color
                is_muted = false
            end
            volume_bar.value = tonumber(volume)
            volume_bar.color = fill_color
            volume_bar.background_color = bg_color
        end
        )
end

volume_bar.muted = function ()
    return is_muted
end

volume_bar.hover = function (hover_in)
    hover = hover_in
end

update_widget()

-- Sleeps until pactl detects an event (volume up/down/toggle mute)
local volume_script = [[
  bash -c '
  pactl subscribe 2> /dev/null | grep --line-buffered "sink #0"
  ']]

awful.spawn.with_line_callback(volume_script, {
        stdout = function(line)
            update_widget()
        end
    })

return volume_bar
