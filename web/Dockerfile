FROM debian:latest
ARG fqdn
ARG email

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    nano apache2 php libapache2-mod-php php-imap curl netcat certbot python3-certbot-apache openssl

RUN a2enmod php7.4
RUN a2enmod rewrite
RUN a2enmod ssl

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache
EXPOSE 80

# Copy this repo into place.
RUN rm -rf /var/www
RUN mkdir -p /var/www
RUN echo "ServerName $fqdn" >> /etc/apache2/apache2.conf
RUn echo "ServerTokens Prod\nServerSignature Off\nFileETag None" >> /etc/apache2/apache2.conf


# Update the default apache site with the config we created.
ADD disposable-mailbox.conf /etc/apache2/sites-enabled/disposable-mailbox.conf
RUN sed -i "s/CHANGEMEFQDN/$fqdn/g" /etc/apache2/sites-enabled/disposable-mailbox.conf
RUN sed -i "s/CHANGEMEMAIL/$email/g" /etc/apache2/sites-enabled/disposable-mailbox.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf

# Entrypoint
ADD entrypoint.sh /root/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/root/entrypoint.sh"]
