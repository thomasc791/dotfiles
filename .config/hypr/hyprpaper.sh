#!/usr/bin/env zsh

rm $HOME/.config/hypr/hyprpaper.conf

preload() {
   images=("${(f)$(ls /home/thomas/.wallpapers/)}")

   for image in $images; do
      echo "preload = $HOME/.wallpapers/$image" >> $HOME/.config/hypr/hyprpaper.conf
   done

   current_image=$HOME/.wallpapers/${images[@]:0:1}
}

preload
echo "" >> $HOME/.config/hypr/hyprpaper.conf

wallpaper() {
   monitors=("${(f)$(hyprctl monitors | grep Monitor | sed "s/.* \(.*\) (.*/\1/")}")

   for monitor in $monitors; do
      echo "wallpaper = $monitor, $current_image" >> $HOME/.config/hypr/hyprpaper.conf
   done
}

wallpaper
