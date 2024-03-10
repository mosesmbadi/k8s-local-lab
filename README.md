# K8s Lab

This lab created for Kubernetes with 1 master and 2 node.
It need to only vagrant [Vagrant](https://www.vagrantup.com/).

## Build and Run
```
$ vagrant up
```

## Kubernetes Installation
I add **installation.sh** for simple installation. You can use it if you want.  
*This script will install [flannel](https://github.com/flannel-io/flannel) network add-on.*

```
$ vagrant ssh master
$$ ./installation.sh
```

Then, **join.sh** file generated  automatically. Just run `./join.sh` in each node.

```
$ vagrant ssh worker1
$$ ./join.sh
```

```
$ vagrant ssh worker2
$$ ./join.sh
```
