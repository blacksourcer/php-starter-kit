#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

MYSQL_INSTALLED=`which mysqld`

if [ ! $MYSQL_INSTALLED ]; then
    echo "Installing MySQL"
    apt-get -y install mysql-server mysql-client
fi

echo "Overriding MySQL config"
cp -fv /vagrant/vagrant/provisions/configs/mysql/50-server.cnf /etc/mysql/conf.d/50-server.cnf

echo "Restarting MySQL"

service mysql restart

echo "Done!"
