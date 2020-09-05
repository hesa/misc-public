#!/bin/bash


export DATE_FMT=
LC_TIME=en_GB.utf8
DATE=$(date)
declare -a TIME_ZONES=("Asia/Tokyo"  "UTC" "Europe/Stockholm" "Europe/Berlin" "America/New_York")

if [ "$1" = "--press-to-quit" ] || [ "$1" = "-ptq" ]
then
    WAIT=true
fi

show_date_tz()
{
    export TZ="$1"
    if [ "$1" = "UTC" ]
    then
        LOCAL_DATE=$(date -u "+%Y-%m-%d %H:%M:%S")
    else
        LOCAL_DATE=$(TZ="$1" date "+%Y-%m-%d %H:%M:%S")        
    fi
    printf "%-30s %s\n" "$1:" "$LOCAL_DATE"
}

show_all() {
    for tz in "${TIME_ZONES[@]}"
    do
        show_date_tz "$tz" "$DATE"
    done
}

show_all

if [ "$WAIT" = "true" ]
then
    echo
    echo "Press enter to contiue..."
    read answer
fi
