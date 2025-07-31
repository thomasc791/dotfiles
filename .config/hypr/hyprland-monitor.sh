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

      hyprctl keyword monitor $monitor, $size, 0x-$height, 1
   done
}

set_monitors
