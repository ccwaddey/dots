# $OpenBSD: dot.profile,v 1.4 2005/02/16 06:56:57 matthieu Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games:$HOME/.cargo/bin
umask 027
export PATH HOME TERM 

cecho() {
	local C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14 C15
    
	C0='\033[30mcolour0\033[0m'
	C1='\033[31mcolour1\033[0m'
	C2='\033[32mcolour2\033[0m'
	C3='\033[33mcolour3\033[0m'
	C4='\033[34mcolour4\033[0m'
	C5='\033[35mcolour5\033[0m'
	C6='\033[36mcolour6\033[0m'
	C7='\033[37mcolour7\033[0m'
	C8='\033[30;1mcolour8\033[0m'
	C9='\033[31;1mcolour9\033[0m'
	C10='\033[32;1mcolour10\033[0m'
	C11='\033[33;1mcolour11\033[0m'
	C12='\033[34;1mcolour12\033[0m'
	C13='\033[35;1mcolour13\033[0m'
	C14='\033[36;1mcolour14\033[0m'
	C15='\033[37;1mcolour15\033[0m'

	echo $CO
	echo $C1
	echo $C2
	echo $C3
	echo $C4
	echo $C5
	echo $C6
	echo $C7
	echo $C8
	echo $C9
	echo $C10
	echo $C11
	echo $C12
	echo $C13
	echo $C14
	echo $C15
}

PS1="\[\033[32m\]\w \$?\\$ \[\033[0m\]"
export MANPAGER=/usr/bin/less

export PKG_PATH='ftp://ftp.usa.openbsd.org/%m'
export CVSEDITOR="emacsclient -a mg"
export CVSROOT='anoncvs@anoncvs1.usa.openbsd.org:/cvs'
export PAGER="less"
export EDITOR="emacsclient -a mg"
export VISUAL="emacsclient -a mg"
SMTPD='/usr/src/usr.sbin/smtpd'

alias ls="ls -AF"
alias u='sndioctl output.level=+.1'
alias d='sndioctl output.level=-.1'
alias mute='sndioctl output.level=0'
. ~/.priv/.alias
alias gi='gethip && getip'
alias g="git --no-pager"
alias tmux='tmux -2'
alias kls='ls | sort -t "-" -k2'
alias mg='emacsclient -a mg'
alias apr='apropos'
alias ffprobe='ffprobe -hide_banner'
alias ffmpeg='ffmpeg -hide_banner'
alias dg='`which git` --git-dir=$HOME/.dots/ --work-tree=$HOME'

set -A complete_doas_1 $(\ls -1 $(echo $PATH | tr  ':' ' ' ) 2>/dev/null | sed '/:$/d')
bind '^w'=kill-region

function man_complete {
  set -A complete_man $(\ls -1 /usr/share/man/man? /usr/X11R6/man/man? /usr/local/man/man[1-9] | sed -e '/^$/d' | sed '/:$/d' | sed '/[^.].$/d' | sed 's/.[0-9]$//')
}

# I would like to do this in the background b/c it takes a second, but
# it doesn't work
man_complete 

createtm() {
	echo "Subject: hey" > tm
	echo >> tm
	for i in 1 2 3 4
	do
		python3 -c "print(\"A\"*$1, end=\"\n\")" >> tm
	done
}

sp() {
	echo $1 | spell
}

set -A complete_cargo_1 bench build check clean doc fetch fix \
    generate-lockfile help init install locate-project login metadata \
    new owner package pkgid publish run rustc rustdoc search test tree \
    uninstall update vendor verify-project version yank
