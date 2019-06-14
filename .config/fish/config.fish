#!/usr/bin/fish

function fish_prompt
    set_color d7ffff
    printf "┌─[ "
    set_color 5fafd7
    printf "加油 "
    set_color 5f87ff
    printf "$USER "
    set_color 5fafd7
    printf (pwd | sed 's,^/home/kyle,~,')
    set_color d7ffff
    printf " ]\n└──> "
end

set fish_greeting

# aliases
abbr vim 'nvim'
abbr awm 'cd ~/.config/awesome'
abbr at 'audio-toggle'
abbr um 'usb-mount'
