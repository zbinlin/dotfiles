#!/bin/sh

if [ $# -lt 1 ];
then
    echo "\
Usage: $0 TEMP_DIR_PATH" >&2
    exit 1
fi

TEMP_DIR=$1

if [ ! -d "$TEMP_DIR" ]; then
    mkdir -p "$TEMP_DIR"
fi
if [ ! $(mount -l | awk '{ print $3 }' | grep "$TEMP_DIR") ]; then
    # 如果 aria2 的 file-allocation 使用 falloc，而 ramfs 不支持 falloc，因此这
    # 里改成 tmpfs
    #sudo mount -t ramfs ramfs_tmp $TEMP_DIR
    sudo mount -o mode=0755,nosuid,nodev,uid=$(id -u ${USER}),gid=$(id -g ${USER}) \
               -t tmpfs tmpfs $TEMP_DIR
fi
