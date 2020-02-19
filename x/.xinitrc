# xset +fp /home/bas/.local/share/fonts
# xset fp rehash
xrdb -merge ~/.Xresources
cd ~/Photos/wallpapers || exit
wallpaper=$(random-file.sh 2)
wal -i "$wallpaper"
betterlockscreen -u "$wallpaper"
betterlockscreen -w dim
/usr/bin/setxkbmap -option "caps:swapescape"
cd ~ || exit
/usr/lib/notification-daemon/notification-daemon & exec i3
