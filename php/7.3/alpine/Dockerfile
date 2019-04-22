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

WORKDIR /tmp

# Install language pack
RUN apk --no-cache add ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-i18n-2.25-r0.apk && \
    apk add glibc-bin-2.25-r0.apk glibc-i18n-2.25-r0.apk glibc-2.25-r0.apk

# Iterate through all locale and install it
# Note that locale -a is not available in alpine linux, use `/usr/glibc-compat/bin/locale -a` instead
COPY ./php/scripts/alpine/locale.md /locale.md
RUN cat /locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8

# Set the lang, you can also specify it as as environment variable through docker-compose.yml
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

COPY ./php/scripts/alpine/*.sh /tmp/
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer
COPY --from=mhart/alpine-node:11.14.0 /usr/bin/node /usr/bin/
COPY --from=mhart/alpine-node:11.14.0 /usr/lib/libgcc* /usr/lib/libstdc* /usr/lib/* /usr/lib/

RUN chmod +x /tmp/*.sh \
  && adduser -D $IMAGE_USER \
  && apk add --update --no-cache bash \
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
