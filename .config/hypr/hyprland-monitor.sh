#!/usr/bin/env zsh


set_monitors() {
   monitors=("${(f)$(hyprctl monitors | grep Monitor | sed "s/.* \(.*\) (.*/\1/")}")
   sizes=("${(f)$(hyprctl monitors | grep availableModes)}")

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

set_wallpapers() {
   killall hyprpaper
   zsh /home/thomas/.config/hypr/hyprpaper.sh
   hyprpaper &
}

set_monitors
set_wallpapers
