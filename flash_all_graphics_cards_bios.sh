#!/usr/bin/env bash

if [ $# -lt 1 ];then
        echo "usage: $0 1 <bios_file>"
        exit 1
fi

BIOS=$1

function stop_mining(){
        echo "stop mining"
        killall screen
        sudo service cron stop
        sleep 5
}

function flash_all_cards(){
        echo "all cards mode"
        number_of_available_cards=$(sudo /root/utils/atiflash -i | grep [0-9] | wc -l)

        for i in $(seq 1 $number_of_available_cards)
        do
                echo "####################### flashing $i #######################"
                sudo /root/utils/atiflash -p $i $BIOS
        done
}

stop_mining
flash_all_cards