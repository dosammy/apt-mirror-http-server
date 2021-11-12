FROM ubuntu:21.10
MAINTAINER Terry Chen <seterrychen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV RESYNC_PERIOD 12h

RUN apt-get update \
  && apt-get install --no-install-recommends -y apt-mirror apache2 \
  && mv /etc/apt/mirror.list / \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 80
COPY setup.sh /setup.sh
COPY mirror.list /etc/apt/mirror.list

VOLUME ["/var/spool/apt-mirror"]
CMD ["/bin/bash", "setup.sh"]
