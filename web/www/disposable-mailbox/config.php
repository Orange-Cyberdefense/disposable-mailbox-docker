<?php

// set your time zone:
date_default_timezone_set('Europe/Paris');

// set locale (see supported locales: https://github.com/fightbulc/moment.php#switch-locale)
$config['locale'] = 'fr_FR';

// enable while testing:
error_reporting(E_ALL);
// enable in production:
// error_reporting(0);

// configure this option if you want to allow requests from clients from other domains:
// see https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
// header("Access-Control-Allow-Origin: *");

$config['domains'] = array('site.example');

// Change IMAP settings (check SSL flags on http://php.net/manual/en/function.imap-open.php)
//$config['imap']['url'] = '{mail:993/imap/ssl/novalidate-cert}INBOX';
$config['imap']['url'] = '{mail:143/notls}INBOX';
$config['imap']['username'] = "vmail";
$config['imap']['password'] = "qfigfPu8MFz";

// email domain, usually different from imap hostname:
$config['mailHostname'] = "site.example";

// When to delete old messages?
$config['delete_messages_older_than'] = '14 days ago';

// Mails to those usernames can not be accessed:
$config['blocked_usernames'] = array('root', 'admin', 'administrator', 'hostmaster', 'postmaster', 'webmaster');

// Mails are usually show as Text and only if not available as HTML. You can turn this around to prefer HTML over text.
$config['prefer_plaintext'] = true;
