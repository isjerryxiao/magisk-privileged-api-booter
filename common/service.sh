#!/system/bin/sh
MODDIR=${0%/*}
#boot detection
until [ $(getprop init.svc.bootanim) = "stopped" ]
do
sleep 2
done
#app_process
if [ -f /system/bin/app_process64 ]
then
ln -sf /system/bin/app_process64 /data/local/tmp/app_process
else
ln -sf /system/bin/app_process32 /data/local/tmp/app_process
fi
PATH=/data/local/tmp:$PATH
{ #brevent
exec $(dumpsys package me.piebridge.brevent | grep legacyNativeLibraryDir | cut -b 28-)/*/libbrevent.so &
} &
{ #shizuku
export CLASSPATH=$(dumpsys package moe.shizuku.privileged.api | grep path | cut -b 13-)
until $(ifconfig | grep -q tun0) || $(ifconfig | grep -q wlan0) || $(ifconfig | grep -q data0) || [ $i = 24 ]
do
sleep 5
((i++))
done
exec app_process /system/bin --nice-name=rikka_server moe.shizuku.server.Server &
} &

