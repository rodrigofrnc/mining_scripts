#!/usr/bin/env bash

if [ $# -lt 3 ];then
        echo "usage: $0 <graphics_card_id> <output_dir> <output_file_name>"
        exit 1
fi

GRAPHICS_CARD_ID=$1
OUTPUT_DIR=$2
OUTPUT_FILE=$3

killall screen
sudo service cron stop
/usr/local/bin/rw /mnt/user
sudo /root/utils/atiflash -s $GRAPHICS_CARD_ID  $OUTPUT_DIR/$OUTPUT_FILE.rom
