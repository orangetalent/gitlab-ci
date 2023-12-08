FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_BIN_DIR=/usr/local/bin
ENV COMPOSER_HOME=/root/.composer
ENV PATH="$COMPOSER_BIN_DIR:$PATH"
ENV NODE_MAJOR=20

# Install Ondrej repos for Ubuntu Jammy Jellyfish, PHP, composer and selected extensions
RUN apt-get update \
    && mkdir -p $COMPOSER_HOME \
    && apt-get install -y --no-install-recommends gnupg locales \
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
        php8.3-apcu \
        php8.3-cli \
        php8.3-curl \
        php8.3-bcmath \
        php8.3-gd \
        php8.3-mbstring \
        php8.3-opcache \
        php8.3-intl \
        php8.3-pdo \
        php8.3-pgsql \
        php8.3-mysql \
        php8.3-sqlite3 \
        php8.3-readline \
        php8.3-redis \
        php8.3-xml \
        php8.3-soap \
        php8.3-xmlrpc \
        php8.3-zip \
        rsync \
        libpng-dev \
        libjpeg-dev \
        libtiff-dev \
        libgif-dev \
        awscli \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
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
