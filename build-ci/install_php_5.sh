#!/usr/bin/env bash
#
#  This source file is subject to the MIT License that is bundled
#  with this package in the MIT license.

CURRENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TRAVIS_BUILD_DIR="${TRAVIS_BUILD_DIR:-$(dirname $(dirname $CURRENT_DIR))}"

install_ssh2() {
    sudo apt-get install -y -qq libssh2-1-dev libssh2-1

	git clone -q https://github.com/php/pecl-networking-ssh2 -b php5 /tmp/ssh2
	cd /tmp/ssh2

	phpize &> /dev/null
	./configure &> /dev/null

	make --silent -j4 &> /dev/null
	make --silent install

	if [ -z $(php -m | grep ssh2) ]; then
        phpenv config-add "${TRAVIS_BUILD_DIR}/build-ci/ini/ssh2.ini"
    fi
}