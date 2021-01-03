local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local ntags = 10
local s = awful.screen.focused()
local tag_text = {}

-- Helper function
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.markup = helpers.colorize_text(beautiful.taglist_text_focused[index], beautiful.taglist_fg_focus)
    elseif tag.urgent then
        item.markup = helpers.colorize_text(beautiful.taglist_text_urgent[index], beautiful.taglist_fg_urgent)
    elseif #tag:clients() > 0 then
        item.markup = helpers.colorize_text(beautiful.taglist_text_occupied[index], beautiful.taglist_fg_occupied)
    else
        item.markup = helpers.colorize_text(beautiful.taglist_text_empty[index], beautiful.taglist_fg_empty)
    end
end

-- Create the taglist
local text_taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    layout = {
        spacing = 1,
        layout = wibox.layout.fixed.horizontal
    },
    font = beautiful.taglist_text_font
} 

return text_taglist
