FROM ruby:3.3-slim

ENV NODE_MAJOR=20

RUN apt-get update \
    && apt-get install -y --no-install-recommends git bash curl make gpg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get -y --no-install-recommends install nodejs \
    && apt-get clean \
    && npm install -g @shopify/cli @shopify/theme \
    && npm cache clean --force \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && shopify version \
    && node -v \
    && npm -v

CMD ["bash"]
