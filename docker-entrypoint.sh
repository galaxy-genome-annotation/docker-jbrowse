#!/bin/bash
export JBROWSE_SAMPLE_DATA=/jbrowse/sample_data/
export JBROWSE_DATA=/jbrowse/data/
export JBROWSE=/jbrowse/
export DATA_DIR=/data/
if [ -d "/data/" ];
then
    for f in /data/*.sh;
    do
        [ -f "$f" ] && . "$f"
    done
fi

mkdir -p $JBROWSE_DATA/json/

nginx -g "daemon off;"
