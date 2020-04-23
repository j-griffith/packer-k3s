#!/bin/bash

modprobe overlay
modprobe br_netfilter

echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf

sysctl -p


# Set iptables to legacy mode, see https://github.com/kubernetes/kubernetes/issues/71305
update-alternatives --set iptables /usr/sbin/iptables-legacy

apt-get update
wget https://github.com/rancher/k3s/releases/download/v1.17.4%2Bk3s1/k3s
chmod +x k3s
mv k3s /usr/local/bin/k3s
