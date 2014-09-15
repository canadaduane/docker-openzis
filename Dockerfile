FROM tutum/lamp:latest

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install php5-gd php5-curl \
 && apt-get -y clean

RUN a2enmod rewrite && sed -i "s/AllowOverride FileInfo/AllowOverride All/g" /etc/apache2/sites-enabled/*

ADD OpenZIS /app
ADD config.ini /app/OpenZIS/
ADD init_db.sh /
ADD run.sh /

EXPOSE 80

CMD ["/run.sh"]