#!/bin/bash

BASE_URL=https://www.bbc.co.uk/programmes/b006qykl/episodes/downloads

TMP_DIR=~/.bbc-iot
DEST_DIR=~/Music/bbc-iot

mkdir -p $TMP_DIR
mkdir -p $DEST_DIR

dload_page()
{
    local PAGE=$1
    if [ ! -f $TMP_DIR/$PAGE.html ]
    then
        wget ${BASE_URL}?page=$PAGE -O $TMP_DIR/$PAGE.html
    else
        echo " * already downloaded $PAGE"
    fi
}

dload_from_page()
{
    echo "Download from $1"
    local PAGE=$1
    
    dload_page $PAGE


    grep mp3 $TMP_DIR/$PAGE.html | sed "s,[<> ],\n,g" | grep mp3 | sed 's,source:,\n,g' | grep https | grep -v low | grep -v "^\/" | sed 's,",,g' | sed 's,^href=,,g' | while read URL_
    do
        URL="https:$URL_"
        echo -n " * $URL"
        FILE_NAME=$(basename $URL)
        echo " -->  $FILE_NAME"
        if [ ! -s "$DEST_DIR/$FILE_NAME" ]
        then
            echo " * download $URL -> $DEST_DIR/$FILE_NAME"
            wget "$URL" -O "$DEST_DIR/$FILE_NAME"
            sleep 2
        else
            echo "$DEST_DIR/$FILE_NAME already downloaded, discarding"
        fi
    done
}

#
# main
#
for i in $(seq 1 50)
do
    dload_from_page $i
done
    
