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

# remove greeting message when fish starts
set fish_greeting
# remove underline of paths
set fish_color_valid_path

# aliases
abbr vim 'nvim'
abbr awm 'cd ~/.config/awesome'
abbr at 'audio-toggle'
abbr um 'usb-mount'
