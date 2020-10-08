#!/bin/bash

ECHO=echo
if [ "$1" = "--do" ]
then
    ECHO=
fi

for i in $(ls *.mp3);
do
    YEAR=$(id3v2 --list $i | grep Date | cut -d : -f 2);
    if [ "$YEAR" = "" ] ;
    then
        YEAR=$(id3v2 --list $i | grep Year | grep -v -e Album -e songname | cut -d : -f 2);
    fi ;

    TITLE=$(id3v2 --list $i | grep TIT2 | cut -d : -f 3 | sed 's, ,_,'g);
    if [ "$TITLE" = "" ] ;
    then
        TITLE=$(id3v2 --list $i | grep TIT2 | cut -d : -f 2 | sed -e 's,^ ,,g' -e 's, ,_,'g  -e 's,[()],,g' ) ;
    fi;

    $ECHO mv $i $YEAR-$TITLE.mp3;
done  
