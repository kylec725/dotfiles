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
    printf " ]\n└──❯ "
end

# remove greeting message when fish starts
set fish_greeting
# remove underline of paths
set fish_color_valid_path
# selection color
set fish_color_search_match --background=black
# autocomplete text color
set fish_color_autosuggestion black

# sudo !! command
function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# aliases
abbr vim 'nvim'
abbr ka 'killall'
abbr at 'audio-toggle'
abbr um 'usb-mount'
# git
abbr ga 'git add'
abbr gc 'git commit'
abbr gp 'git push'
abbr gs 'git status'
# navigation
abbr pd 'prevd'
abbr awm 'cd ~/.config/awesome'
abbr school 'cd ~/school'
abbr sem 'cd ~/school/fall19'

# color theme
set nord0 2e3440
set nord1 3b4252
set nord2 434c5e
set nord3 4c566a
set nord4 d8dee9
set nord5 e5e9f0
set nord6 eceff4
set nord7 8fbcbb
set nord8 88c0d0
set nord9 81a1c1
set nord10 5e81ac
set nord11 bf616a
set nord12 d08770
set nord13 ebcb8b
set nord14 a3be8c
set nord15 b48ead

set fish_color_normal $nord4
set fish_color_command $nord9
set fish_color_quote $nord14
set fish_color_redirection $nord9
set fish_color_end $nord6
set fish_color_error $nord11
set fish_color_param $nord4
set fish_color_comment $nord3
set fish_color_match $nord8
set fish_color_search_match $nord8
set fish_color_search_match --background='black'
set fish_color_operator $nord9
set fish_color_escape $nord13
set fish_color_cwd $nord8
set fish_color_autosuggestion black
set fish_color_user $nord4
set fish_color_host $nord9
set fish_color_cancel $nord15
set fish_pager_color_prefix $nord13
set fish_pager_color_completion $nord6
set fish_pager_color_description $nord10
set fish_pager_color_progress $nord12
set fish_pager_color_secondary $nord1
