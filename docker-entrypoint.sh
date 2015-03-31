export JBROWSE_DATA=/jbrowse/sample_data/
export JBROWSE=/jbrowse/
if [ -d "/data/" ];
then
    for f in /data/*.sh;
    do
        [ -f "$f" ] && . "$f"
    done
fi

nginx -g "daemon off";
