FROM ruby:2.5-stretch
MAINTAINER Alysson Vicuña <alysson.vicuna@gmail.com>
USER root


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev openjdk-8-jre-headless lib32z1 lib32ncurses5 g++-multilib

RUN apt-get install -y wget
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh 
RUN bash nodesource_setup.sh 
RUN apt-get install -y build-essential nodejs libssl-dev
RUN npm install express
RUN node --version
RUN npm --version
RUN apt-get install -y git
RUN apt-get install -y unzip
RUN apt-get install -y android-tools-adb
RUN apt-get install -y vim
RUN apt-get install gnupg2 -y
RUN gpg2 --list-keys
RUN gpg2 --refresh-keys
#RUN apt-get install cucumber -y
RUN apt-get upgrade -y
RUN apt-get install -y patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev

RUN npm install -g phantomjs-prebuilt --unsafe-perm --upgrade --silent
# Install Chrome WebDriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# Install Google Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -yqq update && \
    apt-get -yqq install google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

#COPY docker-entrypoint.sh /usr/local/bin/
#ENTRYPOINT ["docker-entrypoint.sh"]

RUN echo "[******] Copying security certified.";
COPY ./src/poupex.com.br.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates

WORKDIR /usr/src/app

COPY ./src/Gemfile /tmp
COPY ./src/Gemfile.lock /tmp
COPY ./src/config.yml /tmp
COPY ./src/cucumber.yaml /tmp

RUN gem update --system
RUN gem install bundler

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
