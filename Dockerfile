# JBrowse
FROM nginx
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7

RUN apt-get -qq update --fix-missing
RUN apt-get --no-install-recommends -y install build-essential zlib1g-dev libxml2-dev libexpat-dev postgresql-client libpq-dev libpng-dev wget unzip perl-doc ca-certificates

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /conda/ && \
    rm ~/miniconda.sh

ENV PATH="/conda/bin:${PATH}"

RUN conda install -y --override-channels --channel iuc --channel conda-forge --channel bioconda --channel defaults jbrowse=1.16.2

RUN rm -rf /usr/share/nginx/html && ln -s /conda/opt/jbrowse/ /usr/share/nginx/html && \
    ln -s /jbrowse/data /conda/opt/jbrowse/data && \
    sed -i '/include += {dataRoot}\/tracks.conf/a include += {dataRoot}\/datasets.conf' /conda/opt/jbrowse/jbrowse.conf
    sed -i '/include += {dataRoot}\/tracks.conf/a include += {dataRoot}\/../datasets.conf' /conda/opt/jbrowse/jbrowse.conf

VOLUME /data
COPY docker-entrypoint.sh /
CMD ["/docker-entrypoint.sh"]
