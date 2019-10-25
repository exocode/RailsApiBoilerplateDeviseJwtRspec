FROM ruby:2.6.3-alpine3.10

MAINTAINER Jan Jezek <mail@jezekjan.com>

# SET standard language
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# environment
ENV APP_HOME /usr/src/app
ENV BUNDLE_PATH /usr/local/bundle

# create appfolder
RUN mkdir -p $APP_HOME

# imagemagick
RUN apk add --no-cache imagemagick
RUN apk add --no-cache git
RUN apk add --no-cache ruby-rdoc
RUN apk add --no-cache --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev

# Use libxml2, libxslt a packages from alpine for building nokogiri
RUN bundle config build.nokogiri --use-system-libraries
# RAILS
WORKDIR $APP_HOME

# Copy the Gemfile and Gemfile.lock into the image to
# cache the bundle install on each build (unless Gemfile is changed)
# slash must be there
ADD Gemfile $APP_HOME/
ADD Gemfile.lock $APP_HOME/

#  --deployment
RUN gem install bundler
RUN bundle install --jobs 4 --retry 5  #--deployment

#USER ${user:-root}
#ARG user
#USER $user

# copy app into container
COPY . $APP_HOME

EXPOSE 3000
