#!/bin/bash
set -e
source /build/buildconfig
set -x

minimal_apt_get_install php5-fpm php5-cli php5-mysql php5-imagick \
    php5-mcrypt php5-curl php5-xcache php5-xdebug \
    php-pear php5-dev php5-memcached php5-dev \
    nginx-extras

#install composer system wide
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
composer global require --dev "phing/phing:2.*"
echo 'PATH=$PATH:/root/.composer/vendor/bin' >> /etc/environment

#less bless
npm config set registry http://registry.npmjs.org/
npm install -g less bless

cp /build/config/nginx_php.conf /etc/nginx/nginx.conf

## Install Nginx runit service.
mkdir /etc/service/nginx
cp /build/runit/nginx /etc/service/nginx/run
touch /etc/service/nginx/down

mkdir /etc/service/nginx-log-forwarder
cp /build/runit/nginx-log-forwarder /etc/service/nginx-log-forwarder/run


