FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_BIN_DIR=/usr/local/bin
ENV COMPOSER_HOME=/root/.composer
ENV PATH="$COMPOSER_BIN_DIR:$PATH"
ENV NODE_MAJOR=16

# Install Ondrej repos for Ubuntu Jammy Jellyfish, PHP, composer and selected extensions
RUN apt-get update \
    && mkdir -p $COMPOSER_HOME \
    && apt-get install -y --no-install-recommends gnupg locales locales-all \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu jammy main" > /etc/apt/sources.list.d/ondrej-php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        git \
        sudo \
        openssh-client \
        bash \
        ca-certificates \
        apt-transport-https \
        curl \
        unzip \
        php8.1-apcu \
        php8.1-cli \
        php8.1-curl \
        php8.1-bcmath \
        php8.1-gd \
        php8.1-mbstring \
        php8.1-opcache \
        php8.1-intl \
        php8.1-pdo \
        php8.1-pgsql \
        php8.1-mysql \
        php8.1-sqlite3 \
        php8.1-readline \
        php8.1-redis \
        php8.1-xml \
        php8.1-soap \
        php8.1-xmlrpc \
        php8.1-zip \
        rsync \
        libpng-dev \
        libjpeg-dev \
        libtiff-dev \
        libgif-dev \
        awscli \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash \
    && apt-get -y --no-install-recommends install nodejs \
    && apt-get clean \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=$COMPOSER_BIN_DIR --filename=composer \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* $COMPOSER_HOME/cache/* \
    && php -v \
    && composer --version \
    && node -v \
    && npm -v

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

CMD ["bash"]
