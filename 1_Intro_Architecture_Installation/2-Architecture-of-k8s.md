# Kubernetes Architecture  

![](https://miro.medium.com/v2/resize:fit:828/format:webp/0*0upfXtjqscQ5NQfN.png)  

In K8s smallest deployment is Pod similar to container in docker  

# Data Plane

## 1)  Container Runtime

The container runtime is the software responsible for running containers, monitor, and manage containers.(e.g., Dockershim, crio, containerd, runc )

### Responsibilities

- **Launching Containers**: Starting containers based on the specifications provided.
- **Monitoring Containers**: Keeping track of the containers' status and health.
- **Managing Containers**: Restarting failed containers, terminating unused containers, etc.


## 2) Kubelet

- The kubelet is a `DAEMON` Service that runs on each node in the Kubernetes cluster.   
- Its primary responsibility is to ensure that containers are running in a pod as specified by the PodSpecs.  
- The kubelet acts as a bridge between the Kubernetes master and the worker nodes, executing the commands sent by the master to maintain the desired state of the pods.

### Responsibilities

- **Pod Execution**: Ensures that containers described in PodSpecs are running and healthy.
- **Health Checking**: Monitors the health of containers and restarts them if necessary.

## 3) Kube-proxy

- Kube-proxy is a network proxy that runs on each node in the cluster.  
-  It maintains network rules on nodes, allowing network communication to pods from network sessions inside or outside of the cluster.   
-  Kube-proxy handles connection forwarding, load balancing, and other functions to enable network connectivity to pods.
- It uses IP tables for networking. 
### Responsibilities

- **Network Rule Maintenance**: Keeps track of network rules to route traffic correctly.
- **Traffic Forwarding**: Forwards traffic to the appropriate pods based on the rules.



![](https://devopscube.com/wp-content/uploads/2022/12/k8s-architecture.drawio-1.png)  

  
# Control Plane Components in Kubernetes


## 1) API Server

- The API server is the front end for the Kubernetes control plane and the main management component of the entire cluster. 

- It exposes the Kubernetes API and processes REST operations. 
- heart of cluster  
- IT decides and makes a desion and remaining components follow those instructions



### Responsibilities

- **API Processing**: Handles all API calls to the Kubernetes cluster.
- **Authentication and Authorization**: Verifies the identity of users and determines what actions they can perform.
- **Request Coordination**: Orchestrates communication between different control plane components.



## 2) etcd

- etcd is a distributed, reliable key-value store for all the cluster data.  
- It stores data about the cluster state, including nodes, namespaces, and the state of individual containers.



- **Configuration Sync**: Synchronizes configuration data across the cluster.


## 3) Kube Scheduler
- API server sends the container details to scheduler .
- This scheduler is responsible for distributing work or containers across multiple nodes.  
- It selects the most appropriate node for running each new pod based on resource requirements, quality of service requirements, affinity and anti-affinity specifications, data locality, inter-workload interference, and deadlines.


### Responsibilities

- **Pod Scheduling**: Determines the best node for running each new pod.
- **Resource Allocation**: Ensures efficient use of resources across the cluster.
- 

## 4) Controller Manager

- The Controller Manager is a daemon that manages all controllers like Replicaset controller,pod controller,Node controller etc.  
-  Ex : Replicaset controller is responsible to maintain desired no of pods in the cluster. To manage all controllers we need controller manager.



## 5) Cloud Controller Manager
- CCM transfers the user requests ( create Load balancer , create storage on AWS s3 ) to cloud understandable language .
    
-  It integrates Kubernetes with cloud providers to manage cloud resources dynamically.
-  CCM code is open source so we can modify according to our requirements

### Responsibilities

- **Dynamic Resource Management**: Manages cloud resources dynamically based on Kubernetes objects.
- **Cloud Provider Integration**: Coordinates with cloud providers to manage resources like load balancers, storage volumes, and more.



---
---

IMP :`Except kubelet remaining all components runs as pods . only kubelet runs as DAEMON`