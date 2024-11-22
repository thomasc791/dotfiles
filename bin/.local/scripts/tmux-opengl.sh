#!/usr/bin/env bash

tmux new -d -s opengl
tmux rename-window opengl
tmux send-keys "pdoc" C-m
tmux send-keys "cd projecten" C-m
tmux send-keys "clear" C-m

tmux new-window -n "terminal"

tmux attach -t opengl
