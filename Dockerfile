FROM ruby:2.6.0-rc2-stretch

USER root

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY ./src/Gemfile ./src/Gemfile.lock ./
RUN bundle install

COPY . .

VOLUME ["/var/www/html"]

RUN echo "[ ***** ***** ***** ] - Copying files to Image ***** ***** ***** "

#Similar ao comando CD do terminal. Permite setar o diretório que o trabalho ocorrerá (Na Imagem).
WORKDIR /var/www/html/

EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]


RUN echo "[******] Descobrindo o usuario Logado";
RUN whoami


CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
#CMD /usr/sbin/apache2ctl -D FOREGROUND






