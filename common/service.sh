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
exec $(dumpsys package me.piebridge.brevent | grep legacyNativeLibraryDir | cut -b 28-)/*/libbrevent.so
} &
{ #shizuku
app_process -Djava.class.path=/storage/emulated/0/Android/data/moe.shizuku.privileged.api/files/server-`getprop ro.build.version.sdk`.dex /system/bin --nice-name=shizuku_server moe.shizuku.server.ShizukuServer
} &

