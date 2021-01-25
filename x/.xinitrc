wallpaper=$(find "$HOME/wallpapers/" -type f | shuf -n 1)
wal -i "$wallpaper"
betterlockscreen -u "$wallpaper"
betterlockscreen -w dim

/usr/bin/setxkbmap -option "caps:swapescape"
xmodmap $HOME/.xmodmap
redshift-gtk &

$HOME/.config/polybar/launch.sh

xrandr --output eDP1 --primary
xrandr --output HDMI1 --right-of eDP1

exec i3
