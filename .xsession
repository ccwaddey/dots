# No bell
/usr/X11R6/bin/xset -b
# Custom keyboard config
xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/xkbtest $DISPLAY
xset r rate 400 25
# setup idle timeout
xidle -no -timeout 540 -program "$HOME/bin/mysuspend" &
# set background
xwallpaper --stretch $HOME/bin/background.png
# Initial programs (clock, terminal, emacs)
export LC_CTYPE=en_US.UTF-8
$HOME/bin/st -n grdc -T grdc -g 60x9+0+0 -e $HOME/bin/grdc &
$HOME/bin/st -F -n st -e /home/me/bin/tmuxattachornew &
emacs -T Emacs &

exec $HOME/bin/speck
