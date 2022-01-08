# What to do to use this configuration

## Install packages

git remote add origin git@github.com:ccwaddey/dots.git
git push origin master

(The syntax for the flavors of some of these packages might be wrong.)

doas pkg_add autoconf-2.69p3 automake-1.15.1 emacs-gtk3 firefox fvwm2 \
	git gnupg ispell mutt-gpgme-sasl poppler poppler-utils xclip xwallpaper 

## Getting the configs

git clone --bare https://github.com/ccwaddey/dots.git $HOME/.dots

alias dg='`which git` --git-dir=$HOME/.dots/ --work-tree=$HOME'

dg checkout

Note that the typical /etc/skel dotfiles include .profile and
.Xdefaults, which you'll need to either delete or backup if you want
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

You might want to change CVSROOT and PKG_PATH to closer
mirrors. You'll also want to create a .priv directory and add a .alias
file to it for any private aliases.

### .emacs

The first time you open up emacs, pdf-tools will try to install. This
wasn't too hard for me to figure out, but your mileage may
vary. Installing all the packages listed at the beginning of this
README will help. You'll then have to restart emacs to use pdf-tools.

The emacs packages that I have installed currently are gh-md,
markdown-mode, multiple-cursors, pdf-tools, rust-mode, and smex. I
believe these will be pulled in by the file.

Depending on the resolution of your display, you'll have to adjust the
":height 200" part of custom-set-faces.

Add a .emacs.el file to your .priv directory.

### .fvwm/FvwmScript-mydatetime

Depending on the resolution of your display, you'll have to adjust the
lines beginning with WindowSize at the top, as well as the Position
and Size lines in both Widget sections. These need to be coordinated
with .fvwm/config as well. It's not hard, just play around with it
until stuff looks centered and pretty. Adjust the Font size stuff too
if needed.

### .fvwm/config

This assumes your terminal is xterm. You need xwallpaper installed to
set the wallpaper. Comment out the xkbcomp lines if you don't want to
use my keyboard layout (which most people won't want).

There are certain shell scripts that get put in ~/bin that this config
needs to run. They are tmuxattachornew and mysuspend.

You'll have to adjust the font sizes depending on your
resolution. Just search for font and adjust to your liking.

Adjust the RightPanel module configuration for your resolution, along
with FvwmScript-mydatetime.

Also run `doas rcctl enable apmd` to have the auto suspend from
mysuspend enabled.

### .gitconfig

Add a .gitconfig file to your .priv directory.

### .muttrc

This file will be harmless if you don't download mutt, but be prepared
to do some configuring if you do, specifically adding a .muttrc file
to your .priv directory.

### .profile

Basically the same advice as for .eksh. Add a .alias file to your
.priv directory and adjust PKG_PATH and CVSROOT to your liking.

### .tmux.conf

You need to have xclip installed to get copy/paste working right.

### .xkb/*

You don't need to worry about anything in here unless you're changing
you're keyboard layout. Just comment out one line in .fvwm.

### bin/*

Compile testhash.c with

cc -Wall testhash.c -o testhash

### .xenodm

In /etc/X11/xenodm, xenodm-config is set up to run Xsetup_0 after
reset (or first), then runs GiveConsole (as root) after you
successfully login.

You need to download the xenocara source code before running make &&
doas make install (mymake shell script)

TODO: 

We need to put myxidle and foggc.png in /etc/X11/xenodm.  Create a
makefile in .xenodm that will install the above two files where they
should go (as well as the three modified normal xenodm config files)
and patch the source code for xenodm, and make and install that as
well.
