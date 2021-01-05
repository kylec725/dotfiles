local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

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

-- Buttons for each tag
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

-- Create the taglist
local text_taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    layout = {
        spacing = 1,
        layout = wibox.layout.fixed.horizontal
    },
    style = {
        spacing = nil
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
    buttons = taglist_buttons
} 

local taglist_container = wibox.container.margin(text_taglist, dpi(7), dpi(0), dpi(0), dpi(0))

-- return text_taglist
return taglist_container
