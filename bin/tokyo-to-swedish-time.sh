#!/bin/bash

# SPDX-FileCopyrightText: 2021 Henrik Sandklef
#
# SPDX-License-Identifier: GPL-3.0-or-later

FOREIGN_DATE="$1"

date --date "TZ=\"Asia/Tokyo\" $FOREIGN_DATE" +"%Y%m%d %H:%M:%S"
