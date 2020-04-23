# Packer files to build rancher bootstrap OVA using vsphere-iso

This builds a simple Ubuntu 18.04 OVA or QCOW2 (WIP) with a K3s Server installed.

## Build an image

Use make, and select your build platform:

### ova-local

Builds an OVA on your local machine using VMware Workstation, Player, Fusion etc

### ova-vsphere

Builds an OVA on a remote vSphere cluster.  Requires modifications to the variables in the
k3s-server.json file

### qcow2

Not implemented yet, but will enable building a qcow2 for use by KVM

## Possible additions

Add vbox support?
