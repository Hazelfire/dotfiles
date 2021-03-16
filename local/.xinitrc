[[ -f ~/.Xresources.dark ]] && xrdb -I$HOME ~/.Xresources.dark
setxkbmap -layout us -variant dvp -option compose:102 -option numpad:shift3 -option kpdl:semi -option keypad:atm -option caps:shift
feh --randomize --bg-fill ~/Images/Haskell.jpg
#udiskie &
picom -l -6 -t -6 --shadow-exclude '!focused' &
shutter --min_at_startup &
#conky &
#conky -c ~/.scheduleconkyrc &
#xinput disable 14
xdotool mousemove 0 0
#xinput disable 9
#xdotool movemouse 0 0
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

#xrandr --setprovideroutputsource modesetting NVIDIA -0
#xrandr --auto
setxkbmap -option compose:prsc
blueman-applet &

# Log everything you do
exec i3 
