#!/bin/bash

while :
do

	# Change the FQDN in config.php
	if grep --quiet CHANGEMEFQDN /var/www/disposable-mailbox/config.php; then
		sed -i "s/CHANGEMEFQDN/$DOMAIN/g" /var/www/disposable-mailbox/config.php
	fi

	# letsencrypt
	if [[ $LETSENCRYPT == "yes" ]]; then
		if [ ! "$(ls -A /etc/letsencrypt/live/)" ]; then
			echo "Creating cert for $(hostname)"
			certbot certonly -d $(hostname) --non-interactive --agree-tos -m $EMAIL --no-eff-email --standalone
			echo "Certificate created"
		fi
	else
		if [ ! "$(ls -A /etc/letsencrypt/live/)" ]; then
			CERTDIR="/etc/letsencrypt/live/$DOMAIN"
			mkdir -p $CERTDIR
			openssl req -x509 -newkey rsa:4096 -keyout $CERTDIR/privkey.pem -out $CERTDIR/fullchain.pem -days 3650 -nodes -subj "/C=FR/ST=None/L=Paris/O=Dis/CN=$DOMAIN"
		fi
	fi

	# apache
	if ! pgrep -x apache2 >/dev/null ; then
		echo "Starting Apache"
		/etc/init.d/apache2 start
	fi

	sleep 15
done
