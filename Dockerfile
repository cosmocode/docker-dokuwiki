FROM php:8.3-apache AS dokuwiki-base

COPY root/build-deps.sh /
RUN /bin/bash /build-deps.sh


FROM dokuwiki-base

ARG DOKUWIKI_VERSION=stable

ENV PHP_UPLOADLIMIT 128M
ENV PHP_MEMORYLIMIT 256M
ENV PHP_TIMEZONE UTC

COPY root /
RUN /bin/bash /build-setup.sh

VOLUME /storage
EXPOSE 8080

RUN chmod +x /dokuwiki-entrypoint.sh
ENTRYPOINT ["/dokuwiki-entrypoint.sh"]
