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
echo "export PATH=$PATH:/root/.composer/vendor/bin" > /etc/profile.d/composer.sh
ln -s /root/.composer/vendor/bin/phing /usr/bin/phing

cp /build/config/nginx_php.conf /etc/nginx/nginx.conf

## Install Nginx runit service.
mkdir /etc/service/nginx
cp /build/runit/nginx /etc/service/nginx/run
touch /etc/service/nginx/down

mkdir /etc/service/nginx-log-forwarder
cp /build/runit/nginx-log-forwarder /etc/service/nginx-log-forwarder/run

mkdir /etc/service/php5-fpm
cp /build/runit/fpm /etc/service/php5-fpm/run
touch /etc/service/php5-fpm/down


