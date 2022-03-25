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
this to go smoothly. If you plan to use git to track your config files
like I do, then also run `dg config status.showUntrackedFiles no` so
that you only see your config files.

If you want to fetch from this repository to see what I'm doing with
my config occasionally, then add the following line to the
.dots/config file under `[remote "origin"]`:

    fetch = +refs/heads/*:refs/remotes/origin/*

I thought this was supposed to be added automatically after a clone,
but it wasn't when I copied my configs to a new laptop.

## After getting the configs

The following files will need to be tweaked depending on your
screen resolution (and maybe other stuff):

### .Xdefaults

These lines I had to add to make xterm work with my keyboard config;
remove them if necessary:

	Shift <Key>KP_Add: insert() \n\
    Shift <Key>KP_Subtract: insert() \n\

This line will need to be adjusted to center the suspend message (note
that the message window is 233x52 on my display):

    xmessage*geometry:      +554+258

Adjust `XTerm*faceSize:20` to an appropriate size.

### .eksh

You might want to change `CVSROOT` and `PKG_PATH` to closer
mirrors. You'll also want to create a `.priv` directory and add a
`.alias` file to it for any private aliases.

### .emacs

The first time you open up emacs, `pdf-tools` will try to install (and
you might get some errors loading .emacs). Fixing all this wasn't too
hard for me to figure out, but your mileage may vary. Installing all
the packages listed at the beginning of this README (especially
autoconf, automake, poppler and poppler-utils) will help, as will
installing the emacs packages listed in the next paragraph. You'll
have to restart emacs a couple of times to get everything working
right.

The emacs packages that I have installed currently are `gh-md`,
`markdown-mode`, `multiple-cursors`, `pdf-tools`, `perspective`,
`rust-mode`, and `smex`. Run `M-x list-packages` and click on each
one, then click install.

Depending on the resolution of your display, you'll have to adjust the
`:height 200` part of the set-face-attribute line.

Add a `.emacs.el` file to your `.priv` directory. Add a file
`perspectives` to your `~/.emacs.d` directory.

### .fvwm/config

#### StartFunction

You need xwallpaper installed to set the wallpaper. Comment out the
`xkbcomp` line if you don't want to use my keyboard layout (which most
people won't want).

#### InitFunction

There are certain programs that get put in `~/bin` that this config
needs to run as intended. They are `tmuxattachornew`, `mysuspend` and
`grdc`. You'll need to `cd ~/bin` and `make grdc` to have the clock
working. Also run `doas rcctl enable apmd` to have the auto suspend from
mysuspend enabled.

#### Russian Stuff

If you don't want a Russian keyboard then you can comment out the
various lines involving Russian stuff.

#### Font Sizes

You'll have to adjust the font sizes depending on your resolution. The
places to do this are `DefaultFont ...`, `MenuStyle * Font ...` and
`*FvwmIdent: Font ...`.

#### MenuFvwmRoot

Comment out the lines for programs you don't have, and add lines for
programs you do have, along with the Icons you want if you have
them. Also comment out the English and Russian lines (and a Nop line
for aesthetics) if you don't want a Russian keyboard option.

#### Keybindings

See the section on default keybindings. If you don't want Russian and
English shortcuts, then comment out the line that has
`SwitchToRussian` in it.

### .gitconfig

Add a `.gitconfig` file to your `.priv` directory. You should put the
following in it:

    [user]
		name = Your Name
		email = you@youremail.whatever

### .muttrc

This file will be harmless if you don't download mutt, but be prepared
to do some configuring if you do, specifically adding a .muttrc file
to your .priv directory. The packages gnupg, mutt, and urlview are for
this config.

### .tmux.conf

You need to have xclip installed to get copy/paste working right.

### .system

There are a couple of system files in here for making my life easier.

If you plan on upgrading frequently by downloading snapshots, then you
might want to put `~/.system/upgrade.site` in the root directory as
`/upgrade.site`. I use this to automatically compile and install a
couple of programs in X that I've tweaked. You'll want to set the
MAKEUSER to yourself probably and `chown root:wheel /upgrade.site` as
root and `chmod 740 /upgrade.site` as well. See the diffs in .xenodm
and .xlock to see what's going on.

The pf.conf file is what I use as my personal firewall. It allows
domain name resolution and time protocol udp packets to initiate from
my machine to anywhere, so I can have a sync'd time and lookup DNS
entries. It allows pings and local network traffic (192.168.0.0/24). I
can also ftp and ssh to a couple OpenBSD mirrors to get updates, as
well as ssh and https to github for fetching from and pushing to
remotes. Finally it allows connections to the most frequent tor
network port, port 9001. Adjust the macros at the top to your
situation, and install it at /etc/pf.conf, owned by root:wheel and
mode 600.

### .urlview

This is only for mutt. It requires urlview.sh in bin. You should run

    mkdir .linksurlview

### .xkb/*

You don't need to worry about anything in here unless you're changing
your keyboard layout. Just comment out one line in .fvwm.

### bin/*

If you want the (modified) grdc program working, simply `cd ~/bin` and
type `make` or `make grdc`.

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

# Default FVWM Keybindings

Note: C = Control, S = Shift, M = Alt/Meta; so CSM-m means hold
Control, Shift and Alt/Meta and then press 'm' (the actual m key, not
Alt/Meta).

CSM-m	: Toggles showing widgets<br>
CSM-x	: Closes window with focus<br>
CSM-w	: Moves window with focus (using mouse)<br>
CSM-q	: Resizes window with focus (using mouse)<br>
CS-m	: Toggle maximization<br>
CS-;	: Lowers current window<br>
CS-P	: Iconifies current window (use Alt-Tab to recover)

CSM-/	: Toggle Russian/English (comment out if unwanted)

CS-n	: Gives information on current window

CS-j	: Go down a screen<br>
CS-k	: Go up a screen<br>
CS-l	: Go right a screen<br>
CS-h	: Go left a screen<br>
CSM-h	: Go left a desktop<br>
CSM-l	: Go right a desktop

CS-c	: Center mouse pointer in screen

CS-y	: Move mouse left (small)<br>
MS-h	: Move mouse left (big)<br>
CS-o	: Move mouse right (small)<br>
MS-l	: Move mouse right (big)<br>
CS-u	: Move mouse down (small)<br>
MS-j	: Move mouse down (big)<br>
CS-i	: Move mouse up (small)<br>
MS-k	: Move mouse up (big)

M-Tab	: Pulls up window list, releasing Alt/Meta selects current entry<br>
CS-/	: Pulls up root menu

Within a menu (the last two keyboard shortcuts), Space exits,
Enter/Backspace selects the current entry (as well as releasing
Alt/Meta when doing Alt/Meta-Tab), j/k go down/up an entry (as well as
Tab/S-Tab), l enters a submenu, h exits a submenu, and typing any
other letter that is underlined in an entry selects that entry (if
multiple entries have the same letter underlined, then repeatedly
typing that letter cycles through those entries; hit enter to select one).
