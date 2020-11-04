xset +fp /home/bas/.fonts
xset fp rehash
xrdb -merge ~/.Xresources
cd ~/Photos/wallpapers || exit
wallpaper=$(random-file.sh 2)
wal -i "$wallpaper"
betterlockscreen -u "$wallpaper"
betterlockscreen -w dim
/usr/bin/setxkbmap -option "caps:swapescape"
cd ~ || exit

xrandr --output eDP1 --primary
xrandr --output HDMI1 --right-of eDP1

/usr/lib/notification-daemon/notification-daemon &

bspwm
