xrdb -merge ~/.Xresources
cd ~/Photos/wallpapers/Favorites/
wallpaper="$(random-file.sh)"
wal -i "$wallpaper"
betterlockscreen -u "$wallpaper"
betterlockscreen -w dim
/usr/bin/setxkbmap -option "caps:swapescape"
cd ~
exec i3
