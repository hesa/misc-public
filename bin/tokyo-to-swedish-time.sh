#!/bin/bash

FOREIGN_DATE="$1"

date --date "TZ=\"Asia/Tokyo\" $FOREIGN_DATE" +"%Y%m%d %H:%M:%S"
