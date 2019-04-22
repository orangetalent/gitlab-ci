FROM php:7.3-alpine

ARG BUILD_DATE
ARG VCS_REF

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    IMAGE_USER=php \
    HOME=/home/$IMAGE_USER \
    COMPOSER_HOME=$HOME/.composer \
    PATH=$HOME/.yarn/bin:$PATH \
    NODE_VERSION=11.14.0 \
    NPM_VERSION=6 \
    YARN_VERSION=latest \
    PHP_VERSION=7.3

WORKDIR /tmp

COPY ./php/scripts/alpine/*.sh /tmp/
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer
COPY --from=mhart/alpine-node:11.14.0 /usr/bin/node /usr/bin/
COPY --from=mhart/alpine-node:11.14.0 /usr/lib/libgcc* /usr/lib/libstdc* /usr/lib/* /usr/lib/

# COPY INSTALL SCRIPTS
RUN chmod +x /tmp/*.sh \
  && adduser -D $IMAGE_USER \
  && mkdir -p /var/www/html \
  && apk add --update --no-cache bash \
  && bash ./languages.sh \
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
