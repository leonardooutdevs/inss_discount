
FROM ruby:3.3.0-slim

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  git \
  libpq-dev \
  libvips \
  pkg-config \
  redis \
  bash \
  bash-completion \
  libffi-dev \
  tzdata \
  postgresql \
  postgresql-client \
  nodejs \
  npm \
  yarn \
  imagemagick \
  chromium \
  chromium-driver

# DEFINE PATH
ENV INSTALL_PATH /inss_discount

RUN mkdir -p "/root/.config/chromium/Crash Reports/pending"

# CREATE DIR
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# BUILD GEMFILE
COPY Gemfile Gemfile.lock ./
RUN bundle install

# COPY PROJECT FOR CONTAINER
# COPY . $INSTALL_PATH
COPY . .


RUN bundle install

EXPOSE 3000