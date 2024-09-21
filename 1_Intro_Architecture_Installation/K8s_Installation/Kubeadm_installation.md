
## Installing Kubernetes Cluster with kubeadm

#### Step 1: Launch EC2 Instances

Launch 3 x `t2.medium` EC2 instances with 15GB root volumes. In the "Advanced Details" section of the launch configuration, add the following to the User Data to disable swap:

```bash
#!/bin/bash
sudo apt update && apt install -y net-tools unzip
sudo swapoff -a
sudo apt install sed -y
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```


#### Step 2: Install Container Runtime on Each Server

SSH into each server using their public IP and install `containerd`:

```bash
sudo apt update && apt install containerd -y

ps -ef | grep -i containerd | grep -v grep  # to check the containerd is installed or not

apt install net-tools

netstat -nltp | grep -i containerd | grep -v grep  # to check the containerd is listening or not
```

#### Step 3: Install Kubernetes Tools

Open the [Kubernetes official documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) to install the necessary tools for Kubernetes.

select stabe version means 1 before version to latest version  

install step 1, 2, 3

Install `kubelet`, `kubeadm`, and `kubectl` on all nodes:

```bash
sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl
```



#### Step 4: Initialize the Control Plane (Master Node)

On the master node, enable necessary kernel modules and initialize the Kubernetes control plane:

```bash
sudo modprobe br_netfilter

echo 1 > /proc/sys/net/ipv4/ip_forward

sudo kubeadm init --cri-socket /run/containerd/containerd.sock \
--pod-network-cidr=192.168.0.0/16
```

Set up `kubectl` for the master node:

```bash
mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Verify that the Kubernetes control plane is running:

```bash
kubectl get pods -n kube-system
```



#### Step 5: Install Calico CNI for Pod Networking


```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
```

#### Troubleshooting

If the node is not ready, use the following command to remove the `not-ready` taint:

```bash
kubectl get nodes

kubectl taint node <node-name> node.kubernetes.io/not-ready-
```
---
---
#### Step 6: Adding Worker Nodes to the Cluster

#### Disable Swap on Worker Nodes 
If you didn't added this is Advanced settings while creating instance then do this otherwise skip this.  


```bash
sudo swapoff -a

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo apt update && apt install -y net-tools unzip
```

On each worker node, install the container runtime:

```bash
sudo apt update && apt install containerd -y
```

On each worker node, install `kubelet`, `kubeadm`, and `kubectl`:

```bash
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

sudo modprobe br_netfilter

echo 1 > /proc/sys/net/ipv4/ip_forward
```


#### Step 7: Join Worker Nodes to the Cluster
On the `master node`, generate the token and join command:

```bash
kubeadm token generate

kubeadm token create <generted token> --print-join-command
```

#### Step 8:

Copy/Run the generated `kubeadm join` command on each `worker node`.

---

#### Step 9: Verify Cluster Status

On the master node, verify that the worker nodes have joined the cluster:

```bash
kubectl get nodes
```

#### Step 10: label the worker nodes

```bash
kubectl label node <ip address/ node-name> node-role.kubernetes.io/worker=true
```



