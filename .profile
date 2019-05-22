#!/bin/sh

# Adds '~/.scripts' and all subdirectories to $PATH
export PATH="$PATH:$HOME/.bin:$(ruby -e 'print Gem.user_dir')/bin:/home/kyle/.cargo/bin"

eval `opam config env`
