#!/bin/bash

. /etc/symfony_environment.sh

rm -f  /var/run/apache2.pid /run/apache2.pid /run/apache2/apache2.pid

/usr/sbin/apachectl -D FOREGROUND
