FROM ruby:3.0-alpine

ENV BUNDLER_VERSION=2.2.22

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcompat \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \ 
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      sqlite \
      tzdata \
      yarn 

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN gem install bundler -v 2.2.22

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle config path /usr/local/bundle/gems

RUN bundle check || bundle install 

COPY package.json yarn.lock ./

RUN yarn install --check-files

COPY . ./ 

ENTRYPOINT ["./bin/docker-entrypoint.sh"]