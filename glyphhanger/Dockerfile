FROM python:3-alpine

ENV NPM_CONFIG_PREFIX=/root/.npm-global
ENV PATH=$PATH:/root/.npm-global/bin

RUN apk add --update --no-cache --virtual build-dependencies npm git build-base \
  &&  pip install fonttools \
  # Install Brotli
  && git clone https://github.com/google/brotli \
  && cd brotli \
  && python setup.py install \
  && cd ../ \
  && rm -rf brotli \
  # Install Zopfli
  && git clone https://github.com/anthrotype/py-zopfli \
  && cd py-zopfli \
  && git submodule update --init --recursive \
  && python setup.py install \
  && cd ../ \
  && rm -rf py-zopfli \
  # Install Glyphhanger
  && npm install -g glyphhanger --unsafe-perm=true \
  && glyphhanger --version \
  && apk del build-dependencies \
  && rm -rf /root/.npm-global/lib/node_modules/glyphhanger/node_modules/puppeteer

CMD ["bash"]
