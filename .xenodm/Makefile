

myxidle: myxidle.c
	cc -Wall myxidle.c -o myxidle

install:
	install -cF  -o root -g bin -m 644 foggc.png /etc/X11/xenodm/foggc.png
	install -cF  -o root -g bin myxidle     /etc/X11/xenodm/myxidle
	install -bCF -o root -g bin GiveConsole /etc/X11/xenodm/GiveConsole
	install -bCF -o root -g bin Xsetup_0    /etc/X11/xenodm/Xsetup_0
	install -bCF -o root -g bin Xresources  /etc/X11/xenodm/Xresources

patch:
	patch /usr/xenocara/app/xenodm/greeter/Login.c Login.c.diff
	install -CF -g wsrc mymake /usr/xenocara/app/xenodm/mymake
	cd /usr/xenocara/app/xenodm/mymake && mymake
