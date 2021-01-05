local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local ntags = 10
local s = awful.screen.focused()
local tag_text = {}

-- Colorize helper function
function colorize_text(txt, fg)
    return "<span foreground='" .. fg .."'>" .. txt .. "</span>"
end

-- Update taglist helper function
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.markup = colorize_text(beautiful.taglist_text_focused[index], beautiful.taglist_fg_focus)
    elseif tag.urgent then
        item.markup = colorize_text(beautiful.taglist_text_urgent[index], beautiful.taglist_fg_urgent)
    elseif #tag:clients() > 0 then
        item.markup = colorize_text(beautiful.taglist_text_occupied[index], beautiful.taglist_fg_occupied)
    else
        item.markup = colorize_text(beautiful.taglist_text_empty[index], beautiful.taglist_fg_empty)
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
    widget_template = {
        widget = wibox.widget.textbox,
        create_callback = function(self, tag, index, _)
            self.align = "left"
            self.valign = "center"
            self.font = beautiful.taglist_text_font

            update_taglist(self, tag, index)
        end,
        update_callback = function(self, tag, index, _)
            update_taglist(self, tag, index)
        end,
    },
} 

return text_taglist
