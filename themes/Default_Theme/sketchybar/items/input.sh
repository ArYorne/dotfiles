#!/usr/bin/env sh

sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
    	   --add item input right \
    	   --set input script="$PLUGIN_DIR/input.sh" \
    	   			   background.color=$PURPLE \
    	   			   background.height=22 \
    	   			   icon.font="$FONT:Bold Italic:17.0" \
     	   --subscribe input input_change
