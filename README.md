# JBrowse

Configurable docker image for [GMOD's JBrowse](https://github.com/gmod/jbrowse/).

[http://jbrowse.org/](http://jbrowse.org/)

This docker image allows customisation of loaded data; by placing
executable shell scripts in the mounted folder, you can easily load data
on boot.

# Supported tags and respective `Dockerfile` links

-   [`1.11.6`, (*1.11.6/Dockerfile*)](https://github.com/erasche/docker-jbrowse/blob/85291f193b318c7e7b96f58f7b326b852613e679/Dockerfile)
-   [`1.12.0`, (*1.12.0/Dockerfile*)](https://github.com/erasche/docker-jbrowse/blob/72f51bbf9126a5e2cfa9755c58be12c0b7dc55fd/Dockerfile)
-   [`1.12.1`, (*1.12.1/Dockerfile*)](https://github.com/erasche/docker-jbrowse/blob/a2d0717628a68b30cc9b9f93b63afa0971028024/Dockerfile)
-   [`1.12.3`, (*1.12.3/Dockerfile*)](https://github.com/erasche/docker-jbrowse/blob/d105c1a63a09ac16679e8af53b60e4da1bb703f4/Dockerfile)
-   [`1.12.5`, (*1.12.5/Dockerfile*)](https://github.com/erasche/docker-jbrowse/blob/ddd9462d79dcd5bcfb9458953400aac1d3c81144/Dockerfile)

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

## Licence (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
