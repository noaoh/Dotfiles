if [ ! "$DBUS_SESSION_BUS_ADDRESS" ]; then
	eval "$(dbus-launch --sh-syntax --exit-with-x11)"
fi

feh --bg-scale ~/Pictures/wallpapers/void-wallpaper.png
xrdb -merge ~/.Xresources
sxhkd &
picom -b

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec bspwm

