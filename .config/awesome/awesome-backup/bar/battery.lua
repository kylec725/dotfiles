local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Configuration
local update_interval = 30            -- in seconds

local battery = wibox.widget.textbox()

local bat_script = "acpi | awk '{ print $3 $4 }'"

local first_warning = true
local bat_not = nil
local function update_widget()
    awful.spawn.easy_async_with_shell(bat_script, function(stdout)
        -- local text = string.match(stdout, '%d+%%')
        local status, percent = stdout:match('(.+),(%d+%%).*')
        charge = tonumber(string.match(percent, '%d+'))
        local icon
        if (status == "Charging") then
            icon = ""
            bat_not = nil
        elseif (charge >= 0 and charge < 15) then
            icon = ""
            if (charge <= 10 and bat_not == nil) then
                bat_not = naughty.notify({
                        text = "Battery Critical",
                        icon = beautiful.battery_icon,
                        preset = naughty.config.presets.critical,
                        timeout = 0,
                        position = "bottom_middle"
                    }).id
            end
        elseif (charge >= 15 and charge < 40) then
            icon = ""
            if (charge == 20 and first_warning) then
                naughty.notify({
                        text = "Battery Low",
                        icon = beautiful.battery_icon,
                        preset = naughty.config.presets.critical,
                        timeout = 12,
                        position = "bottom_middle"
                    })
                first_warning = false
            elseif (charge > 20) then
                first_warning = true
            end
            bat_not = nil
        elseif (charge >= 40 and charge < 60) then
            icon = ""
            bat_not = nil
        elseif (charge >= 60 and charge < 80) then
            icon = ""
            bat_not = nil
        else
            icon = ""
            bat_not = nil
        end
        battery.text = icon .. " " .. percent .. "  "
    end)
end

awful.widget.watch(bat_script, update_interval, function(stdout)
    update_widget()
end, battery)

return battery
