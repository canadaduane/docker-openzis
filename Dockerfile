FROM tutum/lamp:latest

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install php5-gd php5-curl \
 && apt-get -y clean

RUN a2enmod rewrite

ADD OpenZIS /app
RUN chown -R www-data:www-data /app/OpenZIS/ZIT_SERVER
RUN chown -R www-data:www-data /app/OpenZIS/ADMIN_SERVER

ADD config.ini /app/OpenZIS/
ADD init_db.sh /
ADD run.sh /
ADD default.apache.conf /etc/apache2/sites-enabled/000-default.conf


EXPOSE 80

CMD ["/run.sh"]