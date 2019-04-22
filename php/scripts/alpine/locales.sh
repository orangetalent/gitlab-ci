#!/usr/bin/env bash

# Install libintl
apk --no-cache add libintl

# Install dev dependencies for musl-locales
apk --no-cache --virtual .locale_build add cmake make musl-dev gcc gettext-dev git

# Clone musl locales source
git clone https://gitlab.com/rilian-la-te/musl-locales

# Build and install musl-locales
cd musl-locales && cmake -DLOCALE_PROFILE=OFF -DCMAKE_INSTALL_PREFIX:PATH=/usr . && make && make install

# Remove sources and compile artifacts
cd .. && rm -r musl-locales
apk del .locale_build
