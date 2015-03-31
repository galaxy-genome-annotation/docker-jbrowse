# JBrowse
# VERSION 1.0
FROM nginx
MAINTAINER Eric Rasche <esr@tamu.edu>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update --fix-missing
RUN apt-get --no-install-recommends -y install git build-essential zlib1g-dev libxml2-dev libexpat-dev

RUN mkdir -p /jbrowse/ && git clone --recursive https://github.com/gmod/jbrowse /jbrowse/ && \
    cd /jbrowse/ && \
    git checkout 1.11.6-release
RUN cd /jbrowse/ && ./setup.sh
RUN cd /jbrowse/ && perl Makefile.PL && make && make install
RUN rm -rf /usr/share/nginx/html && ln -s /jbrowse/ /usr/share/nginx/html
VOLUME "/data"
