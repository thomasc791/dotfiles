#!/usr/bin/env zsh


set_monitors() {
   monitors=("${(f)$(hyprctl monitors | grep Monitor | sed "s/.* \(.*\) (.*/\1/")}")
   sizes=("${(f)$(hyprctl monitors | grep availableModes)}")
   mainMonitor=("${(f)$(hyprctl monitors | grep -B 2 0x05A9 | grep Monitor | sed "s/.* \(.*\) (.*/\1/")}")

   swap_places

   height=0
   for monitor in $monitors; do
      index="${monitors[(ie)$monitor]}"
      size=$(echo ${sizes[index]} | sed "s/.*: //" | awk '{print $1}' )

      sizeHeight=$(echo $size | sed "s/.*x\(.*\)@.*/\1/")
      if [[ $index != "1" ]]; then
         height=$(($height+$sizeHeight ))
      fi

      let scale=1.0

      hyprctl keyword monitor $monitor, $size, 0x-$height, $scale
   done
}

swap_places() {
   for monitor in $monitors; do
      index="${monitors[(ie)$monitor]}"
      if [[ $monitor == $mainMonitor ]]; then
         monitors[index]=$monitors[1]
         monitors[1]=$mainMonitor
      fi
   done
}

set_wallpapers() {
   killall hyprpaper
   zsh /home/thomas/.config/hypr/hyprpaper.sh
   hyprpaper &
}

set_monitors
set_wallpapers
