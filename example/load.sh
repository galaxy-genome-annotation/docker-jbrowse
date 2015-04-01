#!/bin/bash

rm -rf $JBROWSE_DATA;
mkdir -p $JBROWSE_DATA/raw/;

prepare-refseqs.pl --fasta $DATA_DIR/volvox/volvox.fa --out $JBROWSE_DATA;
biodb-to-json.pl -v --conf $DATA_DIR/volvox.json --out $JBROWSE_DATA;

cat $DATA_DIR/volvox/volvox_microarray.bw.conf       >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox_sine.bw.conf             >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox-sorted.bam.conf          >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox-sorted.bam.coverage.conf >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox-paired.bam.conf          >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox.vcf.conf                 >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox_fromconfig.conf          >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox.gff3.conf                >> $JBROWSE_DATA/tracks.conf
cat $DATA_DIR/volvox/volvox.gtf.conf                 >> $JBROWSE_DATA/tracks.conf

$JBROWSE/bin/add-json.pl '{ "dataset_id": "volvox", "include": [ "functions.conf" ] }' \
    $JBROWSE_DATA/trackList.json
cp $DATA_DIR/volvox/functions.conf                  $JBROWSE_DATA/functions.conf

generate-names.pl --safeMode -v --out $JBROWSE_DATA;

if [ ! -e $JBROWSE_DATA/raw/volvox ]; then
    ln -s $DATA_DIR/volvox/ $JBROWSE_DATA/raw/volvox;
fi;
ln -sf $DATA_DIR/volvox.json $JBROWSE_DATA/raw/;

