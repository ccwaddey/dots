#!/bin/sh

if [ ! -d $HOME/.linksurlview ]
then
    mkdir $HOME/.linksurlview
fi

echo "$1" > ~/.linksurlview/$(date "+%m_%e-%H:%M:%S")
