#!/bin/bash
set -e
source /build/buildconfig
set -x

if [[ "$ruby19" = 1 || "$ruby20" = 1 || "$ruby21" = 1 ]]; then
    ruby=1
fi

/build/enable_repos.sh
/build/prepare.sh
if [[ "$ruby" = 1 ]]; then
    /build/pups.sh
fi
/build/utilities.sh

if [[ "$ruby19" = 1 ]]; then /build/ruby1.9.sh; fi
if [[ "$ruby20" = 1 ]]; then /build/ruby2.0.sh; fi
if [[ "$ruby21" = 1 ]]; then /build/ruby2.1.sh; fi
if [[ "$python" = 1 ]]; then /build/python.sh; fi
if [[ "$nodejs" = 1 ]]; then /build/nodejs.sh; fi
if [[ "$redis" = 1 ]]; then /build/redis.sh; fi
if [[ "$memcached" = 1 ]]; then /build/memcached.sh; fi
if [[ "$php5" = 1 ]]; then /build/php5.5.sh; fi
# Must be installed after Ruby, so that we don't end up with two Ruby versions.
if [[ "$ruby" = 1 ]]; then /build/nginx-passenger.sh; fi

/build/finalize.sh
