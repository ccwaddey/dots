all: grdc testhash

grdc: grdc.c
	cc -O2 -pipe -Werror-implicit-function-declaration -MD -MP -o grdc \
		grdc.c -lcurses

testhash: testhash.c
	cc -Wall testhash.c -o testhash
