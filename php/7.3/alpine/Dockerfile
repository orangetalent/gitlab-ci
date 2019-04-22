FROM php:7.3-alpine

ARG BUILD_DATE
ARG VCS_REF

ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH
ENV NODE_VERSION=11.14.0
ENV NPM_VERSION=6
ENV YARN_VERSION=latest
ENV PHP_VERSION=7.3
ENV MUSL_LOCPATH="/usr/share/i18n/locales/musl"

WORKDIR /tmp

COPY ./php/scripts/alpine/*.sh /tmp/
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer
COPY --from=mhart/alpine-node:11.14.0 /usr/bin/node /usr/bin/
COPY --from=mhart/alpine-node:11.14.0 /usr/lib/libgcc* /usr/lib/libstdc* /usr/lib/* /usr/lib/

# Install bash
RUN apk add --update --no-cache bash

# Install locales
RUN bash ./locales.sh

# Set locale
ENV LANG=de_DE.UTF-8
ENV LANGUAGE=de_DE.UTF-8
ENV LC_CTYPE=de_DE.UTF-8
ENV LC_ALL=de_DE.UTF-8

RUN chmod +x /tmp/*.sh \
  && adduser -D $IMAGE_USER \
  && touch ~/.bashrc \
  && mkdir -p /var/www/html \
  && bash ./packages.sh \
  && bash ./extensions.sh \
  && bash ./nodeyarn.sh \
  && composer global require "hirak/prestissimo:^0.3" \
  && rm -rf ~/.composer/cache/* \
  && chown -R $IMAGE_USER:$IMAGE_USER /var/www $HOME \
  && echo "$IMAGE_USER  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
  && bash ./cleanup.sh

USER $IMAGE_USER

WORKDIR /var/www/html

CMD ["php", "-a"]
