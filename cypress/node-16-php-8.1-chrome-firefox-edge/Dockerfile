FROM ubuntu:bionic

# This file merges different files together to have PHP, Node, NPM and different browsers for Cypress.
# - https://github.com/orangetalent/gitlab-ci/blob/main/php/8.1/ubuntu/Dockerfile
# - https://github.com/cypress-io/cypress-docker-images/blob/master/base/14.19.0/Dockerfile
# - https://github.com/cypress-io/cypress-docker-images/blob/master/browsers/node16.14.0-chrome99-ff97/Dockerfile
# - https://github.com/cypress-io/cypress-docker-images/blob/master/browsers/node16.14.0-edge/Dockerfile

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
        php-apcu \
        php-apcu-bc \
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

# Cypress packages (https://github.com/cypress-io/cypress-docker-images/blob/master/base/14.19.0/Dockerfile)
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    libgtk2.0-0 \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libgbm-dev \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb \
    # Install emoji font
    fonts-noto-color-emoji \
    # Install Chinese fonts
    # This list was copied from https://github.com/jim3ma/docker-leanote
    fonts-arphic-bkai00mp \
    fonts-arphic-bsmi00lp \
    fonts-arphic-gbsn00lp \
    fonts-arphic-gkai00mp \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    ttf-wqy-zenhei \
    ttf-wqy-microhei \
    xfonts-wqy \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install browser dependencies (https://github.com/cypress-io/cypress-docker-images/blob/master/browsers/node16.14.0-chrome99-ff97/Dockerfile)
RUN apt-get update && \
    apt-get install -y \
    fonts-liberation \
    libcurl4 \
    libcurl3-gnutls \
    libcurl3-nss \
    procps \
    xdg-utils \
    wget \
    curl \
    bzip2 \
    # Add codecs needed for video playback in Firefox
    # https://github.com/cypress-io/cypress-docker-images/issues/150
    mplayer \
    # Clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install libappindicator3-1 - not included with Debian 11
RUN wget --no-verbose /usr/src/libappindicator3-1_0.4.92-7_amd64.deb "http://ftp.us.debian.org/debian/pool/main/liba/libappindicator/libappindicator3-1_0.4.92-7_amd64.deb" \
    && dpkg -i /usr/src/libappindicator3-1_0.4.92-7_amd64.deb ; \
    apt-get install -f -y \
    && rm -f /usr/src/libappindicator3-1_0.4.92-7_amd64.deb

# Install Chrome browser
# Versions: https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
RUN wget --no-verbose -O /usr/src/google-chrome-stable_current_amd64.deb "http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_100.0.4896.127-1_amd64.deb" \
    && dpkg -i /usr/src/google-chrome-stable_current_amd64.deb ; \
    apt-get install -f -y \
    && rm -f /usr/src/google-chrome-stable_current_amd64.deb

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Install Firefox browser
# Versions: https://ftp.mozilla.org/pub/firefox/releases/
RUN wget --no-verbose -O /tmp/firefox.tar.bz2 https://ftp.mozilla.org/pub/firefox/releases/99.0.1/linux-x86_64/en-US/firefox-99.0.1.tar.bz2 \
    && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
    && rm /tmp/firefox.tar.bz2 \
    && ln -fs /opt/firefox/firefox /usr/bin/firefox

## Setup and install Edge
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list' \
    && rm microsoft.gpg \
    && apt-get update \
    && apt-get install -y microsoft-edge-stable \
    && ln -s /usr/bin/microsoft-edge /usr/bin/edge \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

CMD ["bash"]
