#!/bin/sh
L="$(cat .config/waybar/scripts/location.txt)"

text="$(curl -s "https://wttr.in/$L?format=1" | sed 's/ //g')"
tooltip="$(curl -s "https://wttr.in/$L?0QT" |
  sed 's/\\/\\\\/g' |
  sed ':a;N;$!ba;s/\n/\\n/g' |
  sed 's/"/\\"/g')"

if ! rg -q "Unknown location" <<< "$text"; then
  echo "{\"text\": \"$text\", \"tooltip\": \"<tt>$tooltip</tt>\", \"class\": \"weather\"}"
fi
