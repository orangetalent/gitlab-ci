FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=composer:1 /usr/bin/composer /usr/bin/composer

# Install Ondrej repos for Ubuntu Bionic, PHP7.3, composer and selected extensions - better selection than
# the distro's packages
RUN apt-get update \
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
        php7.3-cli \
        php7.3-curl \
        php7.3-bcmath \
        php7.3-json \
        php7.3-gd \
        php7.3-mbstring \
        php7.3-opcache \
        php7.3-intl \
        php7.3-pdo \
        php7.3-pgsql \
        php7.3-mysql \
        php7.3-readline \
        php7.3-xml \
        php7.3-xmlrpc \
        php7.3-zip \
        rsync \
    && curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
    && apt-get -y --no-install-recommends install nodejs \
    && composer require hirak/prestissimo \
    && composer clear-cache \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && ln -s $HOME/.yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s $HOME/.yarn/bin/yarn /usr/local/bin/yarnpkg \
    && composer --version \
    && composer show \
    && yarn -v \
    && npm -v \
    && node -v \
    && php -v \
    && git --version \
    && locale -a

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

CMD ["bash"]
