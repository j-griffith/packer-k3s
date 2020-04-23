#!/bin/bash

packer build -only=vmware-iso k3s-server.json

rm -rf _output/vmware/*
cd _output/vmware

# Change output artifact to OVA
find rancher-k3s.vmx | xargs -I'{}' ovftool -tt=OVA '{}' rancher-k3s.ova

# Unpack created OVA
tar -xvf rancher-k3s.ova

# Change name of disk file (if we don't do this vSphere complains for some reason)
mv rancher-k3s-disk1.vmdk disk-0.vmdk

# Update disk file name in XML manifest
cot --force  add-disk -f file1 disk-0.vmdk rancher-k3s.ovf

# Pack into OVA again
tar -cvf rancher-k3s.ova rancher-k3s.ovf disk-0.vmdk

# Go back to artifact directory
cd ../../

# Copy the OVA into its final output directory
cp _output/vmware/rancher-k3s.ova images/ova/rancher-k3s.ova

# Add properties to the OVA, this can be used to initialize cloud-init on upload time
cot -f edit-properties images/ova/rancher-k3s.ova \
-t iso \
-p user-data+string \
-p public-keys+string \
-p password+string \
-p instance-id=id-ovf+string \
-p hostname+string \
-p seedfrom+string --user-configurable

# Rename NIC to nic0, this is the name our deployment code expects
cot -f edit-hardware images/ova/rancher-k3s.ova -n 1 --nic-types vmxnet3 --nic-names nic0
cot -f edit-hardware images/ova/rancher-k3s.ova -N nic0

# Change OVA file permissions
chmod -R 755 images/ova/rancher-k3s.ova
