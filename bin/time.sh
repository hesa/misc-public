#!/bin/bash

if [ "$1" != "" ]
then
    REMAINING=$1
fi

while (true);
do
    clear
    banner "$(date '+%H %M %S')"
    sleep 1
    if [ "${REMAINING}" != "" ]
    then
        REMAINING=$(( REMAINING - 1 ))
        if [ $REMAINING -lt 1 ]
        then
            break
        fi
    fi
    
done
