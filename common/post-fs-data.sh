#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread
supolicy --live "allow untrusted_app default_android_serice service_manager find"
supolicy --live "allow untrusted_app su binder { transfer call }"

### topjohnwu/magiskpolicy d7a6127273407a32bccf75e70fa7bbe84c14e4f8
supolicy --live "allow system_server su fifo_file write"
supolicy --live "allow audioserver su fd use"
supolicy --live "allow audioserver su fifo_file write"
### REMOVING in Next Release