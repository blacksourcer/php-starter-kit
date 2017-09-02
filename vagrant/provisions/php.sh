#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

PHP_INSTALLED=`which php`

if [ ! -d /var/log/php-fpm/ ]; then
    echo "Creating log dirs"
    mkdir -p /var/log/php-fpm/
fi

chown -Rv vagrant:vagrant /var/log/php-fpm/

if [ ! $PHP_INSTALLED ]; then
    echo "Installing PHP 7.1 repository"
    add-apt-repository -y ppa:ondrej/php
    apt-get -y update

    echo "Installing PHP7"
    apt-get -y install php php7.1-cli php7.1-fpm

    echo "Installing PHP extensions"
    apt-get -y install php7.1-curl php7.1-bcmath php7.1-mysql php7.1-json php7.1-xml php7.1-mbstring

    echo "Installing PECL extensions"
    apt-get -y install php-redis php-xdebug
fi

if [ ! -f /etc/logrotate.d/php-fpm ]; then
    echo "Configuring daily FPM log rotation";
    cp -fv /vagrant/vagrant/provisions/configs/php/php-fpm /etc/logrotate.d/
fi

echo "Configuring FPM pool";
cp -fv /vagrant/vagrant/provisions/configs/php/app.pool.conf /etc/php/7.1/fpm/pool.d/

echo "Updating xdebug.ini"
cp -fv /vagrant/vagrant/provisions/configs/php/20-xdebug.ini /etc/php/7.1/mods-available/xdebug.ini

echo "Restarting PHP-FPM"
service php7.1-fpm restart

echo "Done!"
