# JBrowse

Configurable docker image for [GMOD's JBrowse](https://github.com/gmod/jbrowse/).

[http://jbrowse.org/](http://jbrowse.org/)

This docker image allows customisation of loaded data; by placing
executable shell scripts in the mounted folder, you can easily load data
on boot.

# Supported tags and respective `Dockerfile` links

-   [`1.11.6`, (*1.11.6/Dockerfile*)](https://github.com/erasche/docker-jbrowse/blob/85291f193b318c7e7b96f58f7b326b852613e679/Dockerfile)
-   [`1.12.0`, (*1.12.0/Dockerfile*)](https://github.com/erasche/docker-jbrowse/blob/72f51bbf9126a5e2cfa9755c58be12c0b7dc55fd/Dockerfile)

## Example:

A `docker-compose.yml` file is provided for your convenience, allowing you to boot up the example quite quickly:

```console
$ docker-compose up
```

## Mount point

Data can be provided to the container via a mount:

```console
$ docker run -v `pwd`/my-data/:/data/ erasche/jbrowse
```

## Startup Scripts

Running the default JBrowse instance is likely uninteresting, and you'd like to
run it with your own data.

This is easy to do, just dump data in a folder and provide some `.sh` script(s)
to load that data on boot. Here is an example of how the volvox data is loaded:

```bash
rm -rf $JBROWSE_DATA/json/yeast/;
bin/prepare-refseqs.pl \
    --fasta sample_data/raw/yeast_scaffolds/chr1.fa.gz \
    --fasta sample_data/raw/yeast_scaffolds/chr2.fa.gzip \
    --out $JBROWSE_DATA/json/yeast;

gunzip -c \
    $JBROWSE_DATA/yeast_scaffolds/chr1.fa.gz \
    $JBROWSE_DATA/raw/yeast_scaffolds/chr2.fa.gzip \
    > $JBROWSE_DATA/raw/yeast_chr1+2/yeast.fa;

bin/biodb-to-json.pl \
    --conf $JBROWSE_DATA/raw/yeast.json \
    --out $JBROWSE_DATA/json/yeast/;

bin/add-json.pl \
    '{ "dataset_id": "yeast" }' \
    $JBROWSE_DATA/json/yeast/trackList.json

bin/generate-names.pl --dir $JBROWSE_DATA/json/yeast/;

```

### Environment Variables

There are a couple environment variables available to startup scripts:

Variable       | Value/Use
-------------- | ---
`JBROWSE`      | The location of the jbrowse installation, including the `index.html`
`JBROWSE_DATA` | Location for the `sample_data` folder which contains publicised data
`DATA_DIR`     | Location of mounted data
