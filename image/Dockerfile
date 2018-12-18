# Use osixia/light-baseimage
# sources: https://github.com/osixia/docker-light-baseimage
FROM osixia/light-baseimage:1.1.1
MAINTAINER Amelia Sara Greene <barelyaprincess@gmail.com>

RUN groupadd -r -g 1000 live555 \
    && useradd -r -g live555 -u 1000 live555

ADD etc /etc

RUN apt-get -y update \
	&& LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
	nginx \
	wget \
	patch \
	build-essential

RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get build-dep -y livemedia-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY live555ProxyServer.cpp.patch /usr/src

RUN set -x \
	&& cd /usr/src \
    && wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz \
    && tar zxvf live555-latest.tar.gz \
    && cd live \
	&& patch -p1 < ../live555ProxyServer.cpp.patch \
    && ./genMakefiles linux-64bit \
    && make \
    && make install

# Add static HTML files for tricking March DVR
ADD html /var/www/html

# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/install-service
RUN /container/tool/install-service

# Add default env variables
ADD environment /container/environment/99-default

# Expose default ldap and ldaps ports
EXPOSE 80 554
