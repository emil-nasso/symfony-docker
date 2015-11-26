#!/usr/bin/augtool -f
#set etc/apache2/sites-available/000-default.conf/VirtualHost/*[self::directive='DocumentRoot']/arg "/var/www/web"
set etc/php5/apache2/php.ini/Date/date.timezone "Europe/Stockholm"
set etc/php5/cli/php.ini/Date/date.timezone "Europe/Stockholm"
set etc/php5/apache2/php.ini/Xdebug/xdebug.max_nesting_level 250
set etc/php5/cli/php.ini/Xdebug/xdebug.max_nesting_level 250
