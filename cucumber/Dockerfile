FROM ruby:2.6.0-rc2-stretch

USER root

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

MAINTAINER Alysson Vicuña <alysson.vicuna@gmail.com>

#RUN apt-get update && apt-get upgrade

#RUN 
#apk add build-base bash --no-cache && \
#gem install selenium-webdriver cucumber gmail htmlentities && \
#apk del build-base --purge && \
#rm -rf /var/cache/apk/*
#ENTRYPOINT ["bash", "-c"]

#WORKDIR /usr/src/app

COPY ./src/Gemfile ./src/Gemfile.lock ./
RUN bundle install

