#!/bin/bash

FILE="$1"
NAME=$(basename $0)

if [ "$1" = "-h" ] ||  [ "$1" = "--help" ]
then
    echo "NAME"
    echo "  $NAME - fixes Lufthansa's broken ics files"
    echo ""
    echo "SYNOPSIS"
    echo "  $NAME [FILE]"
    echo ""
    echo "DESCRIPTION"
    echo "  Fixes Lufthansa's broken ics files by trimming DSTART and DTEND"
    echo "  tags as well as remove blank lines"
    echo ""
    echo "  If no file is specified stdin is used."
    echo "  $NAME copies resulting (fixed) ics to clipboard"
    echo "  as well as write to a file (for import)"
    echo ""
    exit 0
fi
   
if [ ! -f $FILE ]
then
    echo "File \"$FILE\" does not exist"
    exit 1
fi

if [ "$FILE" = "" ]
then
    OUT_FILE="flight-cal.ics"
    echo "Reading from stdin"
else
    OUT_FILE=$(echo $FILE | sed 's,\.ics,-fixed\.ics,g')
    echo "Reading from $FILE"
fi

cat $FILE | sed -e 's,: ,:,g' -e  '/^[[:space:]]*$/d' > "$OUT_FILE"
cat $OUT_FILE | xsel -b
echo "Copied content to clipboard"
echo "Created file: $OUT_FILE"

