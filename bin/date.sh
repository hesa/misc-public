#!/bin/bash

# SPDX-FileCopyrightText: 2021 Henrik Sandklef
#
# SPDX-License-Identifier: GPL-3.0-or-later


export DATE_FMT="%Y-%m-%d %H:%M:%S  %Z" 
LC_TIME=en_GB.utf8
DATE=$(date)
declare -a TIME_ZONES=("America/Los_Angeles" "America/New_York"  "UTC" "Europe/Stockholm" "Europe/Berlin" "Europe/Rome"  "Europe/Madrid" "Europe/Kiev" "Asia/Kolkata"  "Asia/Hong_Kong" "Asia/Tokyo" )

if [ "$1" = "--press-to-quit" ] || [ "$1" = "-ptq" ]
then
    WAIT=true
fi

show_date_tz()
{
    export TZ="$1"
    if [ "$1" = "UTC" ]
    then
        LOCAL_DATE=$(date -u +"$DATE_FMT")
    else
        LOCAL_DATE=$(TZ="$1" date +"$DATE_FMT")        
    fi
    printf "%-30s %s\n" "$1:" "$LOCAL_DATE"
}

show_all() {
    for tz in "${TIME_ZONES[@]}"
    do
        show_date_tz "$tz" "$DATE"
    done
    echo
    echo "Week: $(date +\"%V\")"
    echo 
}

show_all | sort -n --key=2,2 --key=3,3

if [ "$WAIT" = "true" ]
then
    echo "Press enter to continue..."
    read answer
fi
