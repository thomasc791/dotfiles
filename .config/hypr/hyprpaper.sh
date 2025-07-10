#!/usr/bin/env zsh

rm $HOME/.config/hypr/hyprpaper.conf

preload() {
   images=("${(f)$(ls /home/thomas/.wallpapers/)}")

   for image in $images; do
      echo "preload = $HOME/.wallpapers/$image" >> $HOME/.config/hypr/hyprpaper.conf
   done

   random_image=("${(f)$(ls -A /home/thomas/.wallpapers/ | shuf)}")
}

preload
echo "" >> $HOME/.config/hypr/hyprpaper.conf

wallpaper() {
   monitors=("${(f)$(hyprctl monitors | grep Monitor | sed "s/.* \(.*\) (.*/\1/")}")

   i=0

   for monitor in $monitors; do
      current_image=$HOME/.wallpapers/${random_image[@]:$i:1}
      ((i++))
      echo $current_image
      echo "wallpaper = $monitor, $current_image" >> $HOME/.config/hypr/hyprpaper.conf
   done
}

wallpaper
