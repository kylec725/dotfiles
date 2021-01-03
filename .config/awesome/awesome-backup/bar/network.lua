local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Configuration
local update_interval = 10            -- in seconds

local network = wibox.widget.textbox()
network.text = "-----"

-- local net_script = "nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2 | cut -c 5- | | awk '{ print $1 }'"
local net_script = "nmcli connection show | grep wlp2s0"

local function update_widget()
    awful.spawn.easy_async_with_shell(net_script, function(stdout)
        -- text = string.match(stdout, '%d+%%')
        local text = stdout:match('(.+%S)%s+(%S+)  wifi')
        local icon = ""
        -- icon = ""
        if (text == nil or text == "") then
            text = "-----"
        end
        network.text = icon .. " " .. text .. "  "
    end)
end

awful.widget.watch(net_script, update_interval, function(stdout)
    update_widget()
end, network)

return network
