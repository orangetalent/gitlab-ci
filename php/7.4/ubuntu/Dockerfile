FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_BIN_DIR=/usr/local/bin
ENV COMPOSER_HOME=/root/.composer
ENV PATH="$COMPOSER_BIN_DIR:$PATH"

# Install Ondrej repos for Ubuntu Bionic, PHP7.4, composer and selected extensions - better selection than
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
        php-apcu \
        php-apcu-bc \
        php7.4-cli \
        php7.4-curl \
        php7.4-bcmath \
        php7.4-json \
        php7.4-gd \
        php7.4-mbstring \
        php7.4-opcache \
        php7.4-intl \
        php7.4-pdo \
        php7.4-pgsql \
        php7.4-mysql \
        php7.4-sqlite3 \
        php7.4-readline \
        php7.4-redis \
        php7.4-xml \
        php7.4-soap \
        php7.4-xmlrpc \
        php7.4-zip \
        rsync \
        libpng-dev \
        libjpeg-dev \
        libtiff-dev \
        libgif-dev \
        awscli \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get -y --no-install-recommends install nodejs \
    && apt-get clean \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && ln -s $HOME/.yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s $HOME/.yarn/bin/yarn /usr/local/bin/yarnpkg \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=$COMPOSER_BIN_DIR --filename=composer --version=1.10.19 \
    && $COMPOSER_BIN_DIR/composer global require "hirak/prestissimo:^0.3" \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* $COMPOSER_HOME/cache/* \
    && php -v \
    && composer --version \
    && node -v \
    && npm -v \
    && yarn -v

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

CMD ["bash"]
