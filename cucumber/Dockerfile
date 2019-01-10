FROM centos:centos7
MAINTAINER Alysson Vicuña <alysson.vicuna@gmail.com>
USER root

# install dependencies
RUN yum update && yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel \
   libyaml-devel libffi-devel openssl-devel make \
   bzip2 autoconf automake libtool bison iconv-devel sqlite-devel

# install auxiliar tools
RUN yum install -y git which vim unzip

COPY ./src/google-chrome.repo /etc/yum.repos.d/
RUN yum install -y google-chrome-stable

WORKDIR /tmp
RUN wget http://mirror.centos.org/centos/7/os/x86_64/Packages/GConf2-3.2.6-8.el7.x86_64.rpm
RUN rpm2cpio GConf2-3.2.6-8.el7.x86_64.rpm | cpio -idmv 

RUN mkdir -p /opt/google/chrome/lib/
RUN cp /tmp/usr/lib64/libgconf-2.so.4 /opt/google/chrome/lib/
RUN cp /tmp/usr/lib64/libgconf-2.so.4.1.5 /opt/google/chrome/lib/

RUN export LD_LIBRARY_PATH=/opt/google/chrome/lib/:$LD_LIBRARY_PATH && echo "$LD_LIBRARY_PATH"

RUN echo "export PATH=$PATH" > /etc/environment

RUN echo "[******] Copying security certified.";
#COPY ./src/poupex.com.br.crt /usr/local/share/ca-certificates/ #if Debian or Ubuntu
#RUN update-ca-certificates #if Debian or Ubuntu
#if RedHat or CentOs
COPY ./src/poupex.com.br.crt /tmp
COPY ./src/poupex.com.br.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust check
RUN update-ca-trust enable
RUN update-ca-trust extract
RUN update-ca-trust 

RUN curl -s "https://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip" > chromedriver.zip
RUN unzip chromedriver.zip && mv chromedriver /usr/local/bin/

WORKDIR /usr/src/app/cucumber-glpi

COPY ./src/config.yml /tmp
COPY ./src/cucumber.yaml /tmp
COPY ./src/env.rb /tmp

# Instalando o Ruby e atualizando as dependencias
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && rvm reload && rvm install 2.5 && rvm use 2.5 --default && ruby --version && gem update --system && gem install bundler && gem update"

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/bin/bash" , "-c", "source /etc/profile.d/rvm.sh && rvm reload && docker-entrypoint.sh && tail -f /dev/null"]
