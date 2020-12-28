#!/usr/bin/env bash

if [ $# -lt 2 ];then
        echo "usage: $0 <bios_file> <first_card_number> [ <second_card_number> ... ]"
        exit 1
fi

BIOS=$1
shift 1
CARD_ARRAY=( "$@" )

function stop_mining(){
        echo "stop mining"
        killall screen
        sudo service cron stop
        sleep 5
}

function flash_specific_card() { 
        for i in "${CARD_ARRAY[@]}"
        do
                echo "####################### flashing $i #######################"
                sudo /root/utils/atiflash -p $i $BIOS
        done
} 


echo "Falshing cards: ${CARD_ARRAY[@]}"

stop_mining
flash_specific_card