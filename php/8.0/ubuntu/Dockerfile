FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_BIN_DIR=/usr/local/bin
ENV COMPOSER_HOME=/root/.composer
ENV PATH="$COMPOSER_BIN_DIR:$PATH"

# Install Ondrej repos for Ubuntu Bionic, PHP, composer and selected extensions - better selection than
# the distro's packages
RUN apt-get update \
    && mkdir -p $COMPOSER_HOME \
    && apt-get install -y --no-install-recommends gnupg locales locales-all \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" > /etc/apt/sources.list.d/ondrej-php.list \
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
        php8.0-apcu \
        php8.0-cli \
        php8.0-curl \
        php8.0-bcmath \
        php8.0-gd \
        php8.0-mbstring \
        php8.0-opcache \
        php8.0-intl \
        php8.0-pdo \
        php8.0-pgsql \
        php8.0-mysql \
        php8.0-sqlite3 \
        php8.0-readline \
        php8.0-redis \
        php8.0-xml \
        php8.0-soap \
        php8.0-xmlrpc \
        php8.0-zip \
        rsync \
        libpng-dev \
        libjpeg-dev \
        libtiff-dev \
        libgif-dev \
        awscli \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash \
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
