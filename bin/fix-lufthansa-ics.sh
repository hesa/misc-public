#!/bin/bash

FILE="$1"

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

#cat Calendar_PKOX4M.ics | sed -e 's,: ,:,g' -e  '/^[[:space:]]*$/d' > lf.ics
