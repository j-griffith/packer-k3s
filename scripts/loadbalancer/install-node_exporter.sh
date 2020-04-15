set -eu

# Download from github and install the node_exporter binary into /usr/sbin
curl -sL https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz | tar --strip-components=1 -zx -C /usr/sbin/

# Create a node_exporter system user
adduser --system --no-create-home --shell /bin/nologin node_exporter

# Enable service
cp /tmp/node_exporter/node_exporter /etc/default
cp /tmp/node_exporter/node_exporter.service /etc/systemd/system
systemctl enable node_exporter
systemctl restart node_exporter
