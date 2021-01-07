#!/usr/bin/fish

# Bash is still the system's default shell so that bash scripts remain compatible

function fish_prompt
    set_color d7ffff
    # printf "┌─[ "
    printf "[ "
    set_color 5fafd7
    printf "加油 "
    set_color 5f87ff
    printf "$USER "
    set_color 5fafd7
    printf (pwd | sed 's,^/home/kyle,~,')
    set_color d7ffff
    printf " ] "
    set_color ffffff
    _pure_prompt_git_pending_commits
    set_color d7ffff
    # printf " ]\n└──❯ "
    # printf " ]\n ⏺ "
    printf "\n ❯ "
end

# environment variables
set -Ux GOPATH "$HOME/.go"
set PATH $PATH "$HOME/.bin:/home/kyle/.cargo/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$GOPATH/bin"
set -Ux FZF_DEFAULT_COMMAND "rg --files --hidden $HOME"
set -Ux FZF_DEFAULT_OPTS "--no-mouse --bind=tab:up,btab:down --color=prompt:195,pointer:#5ADECD,hl+:#5ADECD,hl:#C574DD,gutter:-1"
set -Ux EDITOR nvim
set -Ux VISUAL nvim

# remove greeting message when fish starts
set fish_greeting
# remove underline of paths
set fish_color_valid_path
# selection color
set fish_color_search_match --background=black
# autocomplete text color
# set fish_color_autosuggestion black

# aliases
abbr vim 'nvim'
abbr ka 'killall'
abbr at 'audio-toggle'
abbr hdmi 'hdmi-toggle'
abbr um 'usb-mount'
alias vlc 'devour vlc'
alias ls 'exa --group-directories-first'
alias lst 'exa --group-directories-first -T'
# git
abbr ga 'git add'
abbr gc 'git commit'
abbr gco 'git checkout'
abbr gpl 'git pull'
abbr gph 'git push'
abbr gs 'git status'
abbr gb 'git branch'
# tmux
abbr tvim 'tmux new-session \; split-window -h -p 30'
# navigation
abbr 2.. '../..'
abbr 3.. '../../..'
abbr 4.. '../../../..'
abbr 5.. '../../../../..'
abbr awm 'cd ~/.config/awesome'
# abbr sl 'cd ~/school'
abbr sem 'cd ~/school/spring21'
