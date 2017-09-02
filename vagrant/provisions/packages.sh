#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

echo "Updating packages"
for APT_PID in $(ps ax | grep -E 'apt-get' | awk '{print $1}'); do
    kill -9 $APT_PID &>/dev/null;
done

DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get -y dist-upgrade

echo "Installing base packages if needed"
apt-get -y install nano mc htop traceroute git bash-completion sudo