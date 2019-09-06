xset +fp /home/bas/.local/share/fonts
xset fp rehash
xrdb -merge ~/.Xresources
cd ~/Photos/wallpapers
wallpaper="$(random-file.sh)"
wal -i "$wallpaper"
betterlockscreen -u "$wallpaper"
betterlockscreen -w dim
/usr/bin/setxkbmap -option "caps:swapescape"
cd ~
# source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
exec i3
