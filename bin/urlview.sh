#!/bin/sh

if [ ! -d $HOME/.linksurlview ]
then
    mkdir $HOME/.linksurlview
fi

echo "$1" > /home/me/.linksurlview/$(date "+%m_%e-%H:%M:%S")
