FROM ruby:2.5-stretch
MAINTAINER Alysson Vicuña <alysson.vicuna@gmail.com>
USER root


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev openjdk-8-jre-headless lib32z1 lib32ncurses5 g++-multilib

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh 
RUN bash nodesource_setup.sh 
RUN apt-get install -y build-essential nodejs libssl-dev
RUN npm install express
RUN node --version
RUN npm --version
RUN apt-get install -y git
RUN apt-get install -y android-tools-adb
RUN apt-get install -y vim
RUN apt-get install gnupg2 -y
RUN gpg2 --list-keys
RUN gpg2 --refresh-keys
RUN apt-get upgrade -y
RUN apt-get install -y patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev

RUN npm install -g phantomjs-prebuilt --unsafe-perm --upgrade --silent

# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt-get install -y wget xvfb unzip

# Set up the Chrome PPA
#RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
#RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
#RUN apt-get update -y
#RUN apt-get install -y google-chrome-stable

# GeckoDriver v0.23.0 
RUN wget -q "https://github.com/mozilla/geckodriver/releases/download/v0.23.0/geckodriver-v0.23.0-linux64.tar.gz" -O /tmp/geckodriver.tgz && tar zxf /tmp/geckodriver.tgz -C /usr/bin/ && rm /tmp/geckodriver.tgz

# chromeDriver v2.35
#RUN wget -q "https://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip" -O /tmp/chromedriver.zip && unzip /tmp/chromedriver.zip -d /usr/bin/ && rm /tmp/chromedriver.zip

# Put Chromedriver into the PATH
#ENV PATH $CHROMEDRIVER_DIR:$PATH


RUN echo "[******] Copying security certified.";
COPY ./src/poupex.com.br.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates

WORKDIR /usr/src/app/cucumber-glpi

#COPY ./src/Gemfile /tmp
#COPY ./src/Gemfile.lock /tmp
COPY ./src/config.yml /tmp
COPY ./src/cucumber.yaml /tmp
COPY ./src/env.rb /tmp

RUN gem update --system
RUN gem install bundler

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
