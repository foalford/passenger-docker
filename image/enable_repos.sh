#!/bin/bash
set -e
source /build/buildconfig
set -x

if [[ "$ruby19" = 1 || "$ruby20" = 1 || "$ruby21" = 1 ]]; then
## Brightbox Ruby 1.9.3, 2.0 and 2.1
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6
    echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list

    ## Phusion Passenger
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
    if [[ "$PASSENGER_ENTERPRISE" ]]; then
        echo deb https://download:$PASSENGER_ENTERPRISE_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt trusty main > /etc/apt/sources.list.d/passenger.list
    else
        echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list
    fi
fi

if [[ "$nodejs" = 1 ]]; then
    ## Chris Lea's Node.js PPA
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
    echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main > /etc/apt/sources.list.d/nodejs.list
fi

if [[ "$redis" = 1 ]];  then
    ## Rowan's Redis PPA
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5862E31D
    echo deb http://ppa.launchpad.net/rwky/redis/ubuntu trusty main > /etc/apt/sources.list.d/redis.list
fi

if [[ "$php5" = 1 ]]; then
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C
    echo deb http://ppa.launchpad.net/ondrej/php5/ubuntu trusty main > /etc/apt/sources.list.d/php5.list
fi
apt-get -qy update
