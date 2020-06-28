#!/bin/bash
function getVolume {
	amixer -c 1 get Master | grep -o '\[.*%\]' | sed 's/\[//' | sed 's/\%\]//';
}

function setVolume {
	amixer -c 1 set Master $1\%;
}

function getVolumeFromFile {
	tail -n 1 $tmp_volume_file;
}

tmp_volume_file=$(mktemp)

bash volume_controller.sh $tmp_volume_file $(getVolume)&
GUI_PID=$!

previous_volume=$(getVolume)
while kill -0 $GUI_PID
do
	current_volume=$(getVolumeFromFile)
	if [[ "$previous_volume" -ne "$current_volume" ]]; then
		echo "$previous_volume" "$current_volume" 
		previous_volume=$current_volume
		setVolume $(getVolumeFromFile)
	fi
done

