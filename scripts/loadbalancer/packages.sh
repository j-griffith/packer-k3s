PACKAGES="
apt-transport-https
build-essential
ca-certificates
cloud-utils
curl
ebtables
gnupg2
jq
keepalived
nginx
ntp
prips
python3
python3-dev
python3-pip
python3-setuptools
resolvconf
socat
software-properties-common
sudo
"
apt-get update
apt-get -y install --no-install-recommends $PACKAGES

curl -sL 'https://getenvoy.io/gpg' | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://dl.bintray.com/tetrate/getenvoy-deb  $(lsb_release -cs) stable"
apt-get update
apt-get -y install --no-install-recommends getenvoy-envoy

pip3 install flask jinja2 wheel
pip3 install uwsgi
