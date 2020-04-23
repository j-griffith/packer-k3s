# Packer files to build rancher bootstrap OVA using vsphere-iso

This builds a simple Ubuntu 18.04 OVA or QCOW2 (WIP) with a K3s Server and Helm-3 installed.

Upon booting form these images you should have a functional Helm and a running K3s single node cluster.

*NOTE* 
To run remotely, you'll need to download `/etc/rancher/k3s/k3s.yaml` modify the IP Address and you can use it for
your kubeconfig and issue commands remotely.

In the spirit of automation, I'm considering adding a web-server to easily pull the config; this could also be used to automate scaling out more nodes.

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
