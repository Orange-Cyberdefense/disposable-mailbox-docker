FROM debian:latest

ARG fqdn
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get -yqq dist-upgrade
RUN apt-get -yqq install apt-utils
RUN apt-get -yqq install nano curl net-tools bash-completion wget lsof nano postfix dovecot-core dovecot-imapd procps && \
    apt-get autoremove -yqq && \
    apt-get clean && \
    /bin/rm -rf /var/lib/apt/lists/*

# OS files
#RUN cp /etc/hosts /etc/hosts.new && sed -i '1s/^/order hosts,bind\nmulti on\n/' /etc/hosts.new && cp -f /etc/hosts.new /etc/hosts
#RUN echo $fqdn > /etc/hostname
#RUN echo "127.0.0.1 $fqdn mail.$fqdn" >> /etc/hosts

# postfix
RUN debconf-set-selections <<< "postfix postfix/mailname string $fqdn"
RUN debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
COPY main.cf /etc/postfix/main.cf
RUN sed -i "s/CHANGEME/$fqdn/g" /etc/postfix/main.cf
COPY virtual /etc/postfix/virtual
RUN sed -i "s/CHANGEME/$fqdn/g" /etc/postfix/virtual
RUN postmap /etc/postfix/virtual

#dovecot
#RUN sed -i 's/^#listen.*/listen \= \*, \:\:/g' /etc/dovecot/dovecot.conf
COPY dovecot.conf /etc/dovecot/dovecot.conf
RUN sed -i 's/^#disable_plaintext_auth.*/disable_plaintext_auth = no/g' /etc/dovecot/conf.d/10-auth.conf
RUN sed -i 's/^auth_mechanisms.*/auth_mechanisms = plain login/g' /etc/dovecot/conf.d/10-auth.conf
RUN sed -i 's/^mail_location.*/mail_location = maildir\:\/var\/mail/g' /etc/dovecot/conf.d/10-mail.conf
RUN sed -i 's/#unix_listener \/var\/spool\/postfix\/private\/auth.*/unix_listener \/var\/spool\/postfix\/private\/auth {\n  mode = 0666\n  user = postfix\n  group = postfix\n }/g' /etc/dovecot/conf.d/10-master.conf

#user account
RUN groupadd -g 5000 vmail
RUN useradd -u 5000 -g vmail -s /usr/sbin/nologin -d /var/mail/vmail -m vmail -p $(openssl passwd -1 qfigfPu8MFz)

ADD entrypoint.sh /root/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/root/entrypoint.sh"]
#ENTRYPOINT ["/etc/init.d/dovecot start && /etc/init.d/postfix start"]
