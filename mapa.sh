#!/usr/bin/env bash
git config --global alias.map "log --all --decorate --oneline --graph"
while true; do
clear
git map
sleep 3
done
