#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

NGINX_INSTALLED=`which nginx`

if [ ! $NGINX_INSTALLED ]; then
    echo "Installing NGINX"
    apt-get -y install nginx

    systemctl daemon-reload &>/dev/null
    systemctl enable nginx &>/dev/null
fi

echo "Overriding NGINX config"
cp -fv /vagrant/vagrant/provisions/configs/nginx/nginx.conf /etc/nginx/nginx.conf

echo "Creating snippets dir"
mkdir -p /etc/nginx/snippets

echo "Importing access.conf snippet"
cp -fv /vagrant/vagrant/provisions/configs/nginx/snippets/access.conf /etc/nginx/snippets/access.conf

echo "Importing php-fpm.conf snippet"
cp -fv /vagrant/vagrant/provisions/configs/nginx/snippets/php-fpm.conf /etc/nginx/snippets/php-fpm.conf

echo "Importing static.conf snippet"
cp -fv /vagrant/vagrant/provisions/configs/nginx/snippets/static.conf /etc/nginx/snippets/static.conf

if [ -f /etc/nginx/sites-enabled/default ]; then
    echo "Removing default host config"
    rm -fv /etc/nginx/sites-enabled/default
fi

echo "Importing app.local host"
cp -fv /vagrant/vagrant/provisions/configs/nginx/sites-available/app.local /etc/nginx/sites-available/app.local
ln -s /etc/nginx/sites-available/app.local /etc/nginx/sites-enabled/app.local 2>/dev/null | tee

echo "Restarting NGINX"
service nginx restart

echo "Done!"
