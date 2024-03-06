#!/bin/bash

while :
do
	# dovecot
	if ! pgrep -x dovecot >/dev/null ; then
		echo "Starting Dovecot"
		/etc/init.d/dovecot start
	fi

	# postfix
	if ! pgrep -x master >/dev/null ; then
                echo "Starting Postfix"
                /etc/init.d/postfix start
        fi
	
	sleep 15
done
