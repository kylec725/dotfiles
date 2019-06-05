local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Configuration
local update_interval = 30            -- in seconds

local battery = wibox.widget.textbox()

local bat_script = "acpi | awk '{ print $4 }'"

local function update_widget()
    awful.spawn.easy_async_with_shell(bat_script, function(stdout)
        -- local text = string.match(stdout, '%d+%%')
        local text = stdout:match('%d+%%')
        charge = tonumber(string.match(text, '%d+'))
        local icon
        if (charge >= 0 and charge < 15) then
            icon = ""
        elseif (charge >= 15 and charge < 40) then
            icon = ""
        elseif (charge >= 40 and charge < 60) then
            icon = ""
        elseif (charge >= 60 and charge < 80) then
            icon = ""
        else
            icon = ""
        end
        battery.text = icon .. " " .. text .. "  "
    end)
end

awful.widget.watch(bat_script, update_interval, function(stdout)
    update_widget()
end, battery)

return battery
