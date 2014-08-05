#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

xset fp default
xset +fp /usr/share/fonts/local/
xset +fp /usr/share/fonts/TTF/
xset fp rehash

# dropboxd

nvidia-settings -a InitialPixmapPlacement=2
exec i3
