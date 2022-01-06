#!/bin/ksh

# So we don't get a recording with no audio
if [ `sysctl -n kern.audio.record` = "0" ]
then
    echo "set sysctl kern.audio.record before recording"
    exit 1
fi

# So we don't accidentally reveal our password
if fgrep -q persist /etc/doas.conf
then
    echo "change doas.conf to \"permit nopass me as root\""
    exit 1
fi

# So we can hear the beep to start recording
xset b

# record.sh to record new, yrecord.sh to record and overwrite
if [ "record.sh" = `basename $0` ]
then
    sleep 3 && xkbbell && sleep 1 &&
	ffmpeg -n -loglevel quiet -f sndio -i snd/1 -f x11grab -r 12 -i :0.0 \
	       -vcodec ffv1 -acodec mp3 $1
elif [ "yrecord.sh" = `basename $0` ]
then
    sleep 3 && xkbbell && sleep 1 &&
	ffmpeg -y -loglevel quiet -f sndio -i snd/1 -f x11grab -r 12 -i :0.0 \
	       -vcodec ffv1 -acodec mp3 $1
elif [ "arecord.sh" = `basename $0` ]
then
    xkbbell && sleep 1 && ffmpeg -n -f sndio -i snd/1 -acodec mp3 $1
fi
     
xset -b
