#!/bin/bash
set -e

tar -C /tmp -xzf /tmp/envoy-lb-components.tgz

# xds user
adduser --disabled-password --gecos "" xds
cp /tmp/xds/91-envoy-users /etc/sudoers.d

# keepalived
chown xds -R /etc/keepalived/
mkdir -p /var/lib/keepalived/prom.d/
chown xds -R /var/lib/keepalived/
cp /tmp/keepalived/notify.sh /var/lib/keepalived/

# xds configuration

mkdir -p /var/lib/xds_config
chown -R xds /var/lib/xds_config

cp /tmp/xds_config/xds_config.py /var/lib/xds_config/
cp /tmp/xds_config/xds_config.ini /var/lib/xds_config/
cp /tmp/xds_config/wsgi.py /var/lib/xds_config/

chown -R xds /var/lib/xds_config/
chgrp -R xds /var/lib/xds_config/

cp /tmp/xds_config/xds_config.service /etc/systemd/system/

# nginx

cp /tmp/nginx/xds_config /etc/nginx/sites-available/xds_config

rm /etc/nginx/sites-enabled/*
ln -s /etc/nginx/sites-available/xds_config /etc/nginx/sites-enabled/xds_config

# envoy

mkdir -p /etc/envoy
chown -R xds /etc/envoy

cp /tmp/envoy/check-envoy.sh /etc/envoy/
cp /tmp/envoy/reload-envoy.sh /etc/envoy/
cp /tmp/envoy/start-envoy.sh /etc/envoy/
cp /tmp/envoy/hot-restarter.py /etc/envoy/

chmod a+x /etc/envoy/*

cp /tmp/envoy/config.yaml /etc/envoy/

chown -R xds /etc/envoy/
chgrp -R xds /etc/envoy/

cp /tmp/envoy/envoy.service /etc/systemd/system/

# services

systemctl enable xds_config
systemctl restart xds_config

systemctl enable envoy
systemctl restart envoy

systemctl enable nginx
systemctl restart nginx
