#!/usr/bin/env bash
# fonte: https://stackoverflow.com/questions/6980090/how-to-read-from-a-file-or-standard-input-in-bash

function log() {
    BASELOG=$(dirname $0)
    LOGFILE="${BASELOG}/scripts-servidor-esus.log"

    while read line
    do
        DATACOMPLETA=$(date "+%Y%m%d %H%M%S")
        echo "${DATACOMPLETA} ${1}: ${line}" | tee -a $LOGFILE
    done < "${2:-/dev/stdin}"
}
