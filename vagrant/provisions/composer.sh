#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

COMPOSER_INSTALLED=`which composer`

if [ ! $COMPOSER_INSTALLED ]; then
    echo "Installing Composer"
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
fi


cd /vagrant/
if [ ! -f /vagrant/composer.lock ]; then
    echo "Installing core composer packages"
    sudo -H -u vagrant composer install
else
    echo "Updating core composer packages"
    sudo -H -u vagrant composer update
fi