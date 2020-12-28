#!/usr/bin/env bash

if [ $# -lt 1 ];then
        echo "mode 1 flash all bios"
        echo "usage: $0 1 <bios_file> <starting_card>"
        echo "mode 2 flash specific card"
        echo "usage: $0 2 <bios_file> <card_number>"
        exit 1
fi

MODE=$1
BIOS=$2
CARD_NUMBER=$3

function stop_mining(){
        echo "stop mining"
        killall screen
        sudo service cron stop
        sleep 5
}

function flash_all_cards(){
        stop_mining
        echo "all cards mode"
        number_of_available_cards=$(sudo /root/utils/atiflash -i | grep [0-9] | wc -l)

        for i in $(seq $CARD_NUMBER $number_of_available_cards)
        do
                echo "####################### flashing $i #######################"
                sudo /root/utils/atiflash -p $i $BIOS
        done
}

function flash_specific_card(){
        stop_mining
        echo "####################### flashing $CARD_NUMBER #######################"

        sudo /root/utils/atiflash -p $CARD_NUMBER $BIOS
}


case $MODE in

  1)
    flash_all_cards
    ;;

  2)
    flash_specific_card
    ;;

  *)
    echo "unknown mode option"
    exit 1
    ;;
esac
