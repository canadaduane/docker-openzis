FROM tutum/lamp:latest

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install php5-gd php5-curl \
 && apt-get -y clean

RUN a2enmod rewrite

ADD OpenZIS /app

# Give permission for Apache2 to use PHP, assets, etc.
RUN chown -R www-data:www-data /app/OpenZIS/ZIT_SERVER
RUN chown -R www-data:www-data /app/OpenZIS/ADMIN_SERVER

# Give permission for PHP session files to be written to default location
RUN chown www-data:www-data /var/lib/php5

# Create directories that OpenZIS expects to exist
RUN mkdir -p /app/OpenZIS/tmp && chown www-data:www-data /app/OpenZIS/tmp
RUN mkdir -p /app/OpenZIS/logs && chown www-data:www-data /app/OpenZIS/logs

ENV CREATE_DATABASE true

ENV DB_HOST 127.0.0.1
ENV DB_NAME openzis
ENV DB_USER root
# ENV DB_PASS
ENV DB_USER2 root
# ENV DB_PASS2

ADD init_db.sh /
ADD run.sh /
ADD default.apache.conf /etc/apache2/sites-enabled/000-default.conf
ADD default_groups.sql /app/OpenZIS/db/mysql/
ADD default_qa.sql /app/OpenZIS/db/mysql/

VOLUME ["/var/lib/mysql", "/var/log/apache2", "/var/log/mysql"]

EXPOSE 80

CMD ["/run.sh"]