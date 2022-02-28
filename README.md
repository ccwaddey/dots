# What to do to use this configuration

## Install packages

    doas pkg_add autoconf automake emacs firefox \
		fvwm2 git gnupg ispell mutt poppler \
		poppler-utils urlview xclip xwallpaper

pkg_add will ask you some questions about flavors/versions. When it
does, answer with the following:

- autoconf: 2.69p3 (or whatever is closest, the patch might be higher)
- automake: 1.15.1 (or whatever is closest, there may be a patch)
- emacs: use the gtk3 flavor (maybe it will be gtk4 or higher at some
  point)
- firefox: I don't recommend the ESR versions; use whatever language
  you want
- mutt: use the gpgme-sasl version
- poppler: 21.12.0 (or higher if no options)
- poppler-utils: 21.12.0 (or higher if no options)

## Getting the configs

Run the following in a terminal:

    git clone --bare https://github.com/ccwaddey/dots.git $HOME/.dots
    alias dg='`which git` --git-dir=$HOME/.dots/ --work-tree=$HOME'
    dg checkout

Note that the typical `/etc/skel` dotfiles include `.profile` and
`.Xdefaults`, which you'll need to either delete or backup if you want
this to go smoothly.

## After getting the configs

The following files will need to be tweaked depending on your
screen resolution (and maybe other stuff):

### .Xdefaults

These lines I had to add to make xterm work with my keyboard config:

	Shift <Key>KP_Add: insert() \n\
    Shift <Key>KP_Subtract: insert() \n\

This line will need to be adjusted to center the suspend message (note
that the message window is 233x52 on my display):

    xmessage*geometry:      +554+258

### .eksh

You might want to change `CVSROOT` and `PKG_PATH` to closer
mirrors. You'll also want to create a `.priv` directory and add a
`.alias` file to it for any private aliases.

### .emacs

The first time you open up emacs, `pdf-tools` will try to install (and
you might get some errors loading .emacs). Fixing all this wasn't too
hard for me to figure out, but your mileage may vary. Installing all
the packages listed at the beginning of this README will help, as will
installing the emacs packages listed in the next paragraph. You'll
have to restart emacs a couple of times to get everything working
right.

The emacs packages that I have installed currently are `gh-md`,
`markdown-mode`, `multiple-cursors`, `pdf-tools`, `perspective`,
`rust-mode`, and `smex`. Run `M-x list-packages` and click on each
one, then click install.

Depending on the resolution of your display, you'll have to adjust the
`:height 200` part of custom-set-faces.

Add a `.emacs.el` file to your `.priv` directory. Add a file
`perspectives` to your `~/.emacs.d` directory.

### .fvwm/FvwmScript-mydatetime

Depending on the resolution of your display, you'll have to adjust the
lines beginning with WindowSize at the top, as well as the Position
and Size lines in both Widget sections. These need to be coordinated
with .fvwm/config as well. It's not hard, just play around with it
until stuff looks centered and pretty. Adjust the Font size stuff too
if needed.

### .fvwm/config

This assumes your terminal is xterm. You need xwallpaper installed to
set the wallpaper. Comment out the `xkbcomp` line if you don't want to
use my keyboard layout (which most people won't want).

There are certain shell scripts that get put in `~/bin` that this config
needs to run. They are `tmuxattachornew` and `mysuspend`.

You'll have to adjust the font sizes depending on your
resolution. Just search for font and adjust to your liking. This is
set up for a 1360x768.

Adjust the RightPanel module configuration for your resolution, along
with FvwmScript-mydatetime.

Also run `doas rcctl enable apmd` to have the auto suspend from
mysuspend enabled.

### .gitconfig

Add a `.gitconfig` file to your `.priv` directory.

### .muttrc

This file will be harmless if you don't download mutt, but be prepared
to do some configuring if you do, specifically adding a .muttrc file
to your .priv directory. The packages gnupg, mutt, and urlview are for
this config.

### .profile

Basically the same advice as for .eksh. Add a `.alias` file to your
`.priv` directory and adjust `PKG_PATH` and `CVSROOT` to your liking.

### .tmux.conf

You need to have xclip installed to get copy/paste working right.

### .upgrade.site

If you plan on upgrading frequently by downloading snapshots, then you
might want to install put .upgrade.site in the root directory as
`/upgrade.site`. I use this to automatically compile and install a
couple of programs in X that I've tweaked. You'll want it to `chown
root:wheel /upgrade.site` as root and `chmod 740 /upgrade.site` as
well. See the diffs in .xenodm and .xlock to see what's going on.

### .urlview

This requires urlview.sh in bin. You should also run 

    mkdir .linksurlview

### .xkb/*

You don't need to worry about anything in here unless you're changing
your keyboard layout. Just comment out one line in .fvwm.

### bin/*

Compile testhash.c with

    cc -Wall testhash.c -o testhash

You don't need to do this unless you want to see what password hashes
look like.

### .xenodm/*

If you just want .xenodm to kinda look like fvwm when you log in, just
cd into this directory and run `make && doas make install`.

By default, the cursor for the login prompt is a vertical one. I've
modified the source code to make the cursor (essentially) be an
underline character.

If you want the underline cursor instead of the default, then download
xenocara.tar.gz (to your home directory in this example; this is the
beginning of getting the xenocara source code for those coming here
from the .xlock section); make sure you have added yourself to the
wsrc group with

    doas user mod -G wsrc $(whoami)

and then logged out and logged back in; and run 

    doas mkdir /usr/xenocara
	doas chgrp wsrc /usr/xenocara
	doas chmod 775 /usr/xenocara
	cd /usr/xenocara
	tar xzf ~/xenocara.tar.gz
	cvs up

(The last command isn't strictly necessary; this is also the end of
getting the xenocara source code.) Then `cd ~/.xenodm` and run `make
patch` and then `cd /usr/xenocara/app/xenodm` and run `./mymake`. This
will make and install the new xenodm so that it uses the underline
cursor. The old xenodm is still running, so you'll have to reboot (or
restart xenodm) to see the new login prompt.

If you're going to put .upgrade.site into the root directory as
/upgrade.site, then this will be done automatically when you upgrade
(useful if you're following current using snapshots).

### .xlock

This section is not necessary, but if you want the "matrix"-style
screensaver that is shown after you resume from a suspend to only show
0s and 1s (like it should) instead of all the Japanese (I think?)
characters, then download the source code for xenocara as described in
.xenodm and run

	cd ~/.xlock
	make patch
	cd /usr/xenocara/app/xlockmore
	make -f Makefile.bsd-wrapper
	doas make -f Makefile.bsd-wrapper install
	
That should patch the code to just give you zeros and ones, compile it
and install it.
