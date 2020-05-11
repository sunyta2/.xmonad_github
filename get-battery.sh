#!/usr/bin/bash
#[[https://gist.github.com/Dnomyar/9c289fcc2668b59e1ffb][My XMonad (xmobar : battery, cpu, memory, volume, time) - ArchLinux · GitHub]]
#(stumpwm:run-shell-command "acpi -b | awk '{print \" [\" $3, $4, $5 \"]\"}'" t)

# Get the maximum volume of any pulseaudio sink channel
# amixer get Master | egrep -o "[0-9]+%"
bat=$(acpi -b | awk '{print " " $3, $4, $5 " "}')
   # (amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1)

echo Bat: $bat

exit 0
