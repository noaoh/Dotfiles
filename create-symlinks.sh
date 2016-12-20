#!/bin/bash
ln -s ~/Dotfiles/.vimrc ~/.vimrc 

ln -s ~/Dotfiles/.bashrc ~/.bashrc 

ln -s ~/Dotfiles/xresources/Xresources.light ~/.Xresources 

ln -s ~/Dotfiles/fonts/terminus ~/.local/share/fonts 
ln -s ~/Dotfiles/fonts/small-type-writing ~/.local/share/fonts 
ln -s ~/Dotfiles/fonts/courierprime-code ~/.local/share/fonts 

mkdir ~/.config/conky
ln -s ~/Dotfiles/conky/conky.conf ~/.config/conky/conky.conf 
ln -s ~/Dotfiles/conky/cmus_now_playing.sh ~/.config/conky/cmus_now_playing.sh

ln -sf ~/Dotfiles/.profile ~/.profile
ln -sf ~/.profile ~/.bash_profile

mkdir ~/.cmus
ln -s ~/Dotfiles/red.theme ~/.cmus
