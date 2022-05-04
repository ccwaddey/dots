# What to do to use this configuration

I recently switched to a custom window manager that's basically just a
stripped down version of dwm. You can use it if you want by checking
out the speck repository at
[speck](https://github.com/ccwaddey/speck). I also switched to using
[st](https://github.com/ccwaddey/st) as my terminal emulator instead
of xterm. These files assume those programs. Getting them is pretty
easy though. Just `git clone` the links above, then run `make install`
(if you're on OpenBSD); I use the package noto-fonts for st, so
beware. This guide assumes you have doas set up; otherwise you'll have
to run doas commands as root.

## Install packages

    doas pkg_add autoconf automake emacs firefox \
		git gnupg ispell mutt noto-fonts poppler \
		poppler-utils urlview xclip xwallpaper

pkg_add will ask you some questions about flavors/versions. When it
does, answer with the following:

- autoconf: 2.69p3 (or whatever is closest, the patch might be higher)
- automake: 1.15.1 (or whatever is closest, there may be a patch)
- emacs: use the gtk3 flavor (maybe it will be gtk4 or higher at some
  point)
- firefox: I don't recommend the ESR versions; use whatever language
  you want; also any other browser is fine
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

### .eksh

You might want to change `CVSROOT` and `PKG_PATH` to closer
mirrors. You'll also want to create a `.priv` directory and add a
`.alias` file to it for any private aliases.

### .emacs

Add a file `perspectives` to your `~/.emacs.d` directory.

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
0s and 1s (as it should) instead of all the Japanese (I think?)
characters, then download the source code for xenocara as described in
.xenodm and run

	cd ~/.xlock
	make patch
	cd /usr/xenocara/app/xlockmore
	make -f Makefile.bsd-wrapper
	doas make -f Makefile.bsd-wrapper install
	
That should patch the code to just give you zeros and ones, compile it
and install it.

### .xsession

Comment out the lines for various things that you don't want or don't
have installed. For example, most won't want the custom keyboard
config, or they won't want the background set by xwallpaper (needs to
be installed from speck or elsewhere), or they won't want to run speck
at all. Choose your own adventure.
