#!/bin/bash
set -e

cd /tmp
wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
dpkg -i mod-pagespeed-*.deb
apt-get -f install

rm mod-pagespeed-*.deb
