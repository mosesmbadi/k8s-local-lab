# Creating a multi-node Kubernetes cluster on local machine
This guide will bring you close to a real world use case of Kubernetes, on your local machine!

Requirements:
1. [VirtualBox](https://www.virtualbox.org/) 
2. [Vagrant](https://www.vagrantup.com/) on our machine. 

May God help you if you have less than 4GB of RAM.

For Kubernetes version `1.24+`

## Provisioning VMs with all necessary tools
```sh
$ git clone https://github.com/mosesmbadi/k8s-local-lab.git
$ cd k8s-local-lab
$ vagrant up
$ vagrant reload
```

## Initializing control plane node
After all VMs are provisioned, follow this [guide](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) to setup our cluster:

```sh
$ vagrant ssh master
$ sudo kubeadm init --apiserver-advertise-address=192.168.56.10 --pod-network-cidr=10.244.0.0/16
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
Let's configure Calico for networking:
```sh
$ kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml
$ kubectl create -f /vagrant/custom-resources.yaml
```

## Joining worker nodes
```sh
$ vagrant ssh node-01
$ sudo kubeadm join 192.168.56.10:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```
The join command can be found after running the `kubeadm init` command above but we can find token and hash values by running the following commands on the control plane node:

```sh
$ kubeadm token list
$ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
   openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'
```

Do the same procedure on each worker node.

Now we should have a 3-node Kubernetes cluster running on our local machine.
here are some commands you can start with:

```sh
$ vagrant ssh master
$ kubectl get node -o wide
```

```sh
$ kubectl cluster-info
```

```sh
$ kubectl get all --all-namespaces

```


![screenshot](./screenshots/k8s-local-dev.png)