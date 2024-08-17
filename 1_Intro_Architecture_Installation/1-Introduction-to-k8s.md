# Kubernetes-K8s
## Introduction ##  
To undesttand Kubernetes (K ubernete(8) s = K8s) we need a clarity on Docker. If you don't know about Docker [learn here](https://github.com/ReddyBytes/Docker)  

__Docker__ is a containerization platform  
**Kubernetes** is a container Orchestration platform   

### What type of problems that we face before K8s ??  

1) __Single Host System :__  
    Docker is a single host system means  

    ![](https://code.visualstudio.com/assets/learn/develop-cloud/containers/container-architecture.png)  

    If incase container A takes lot of memory then Container c may die ( because of containers are ephimeral in nature ) due of less memory which is not good for realtime usage  

2) __Auto-Healing / Self-Healing :__  
If somebody kills or crashes the container then the application stops running which causes users discomfort. And this container will run after manually starts that container. This is very difficult to manage 100's of containers in realtime.  

3) __Auto-Scaling :__  
   Let's say you create a container with 4cpu & 4 gb memory and can handle upto 10000 requests per min. But due to the sale you application receives 20000 requests per min then ur containers may not server as fast as before .  

   In this case Load Balancers will solve this solution by splitting the load to multiple containers .  

4) __Enterprise level Support :__  
   By default docker doesn't support enterprise level support like   
   A ) Load Balancer  
   B ) Firewall  
   C ) Auto Healing  
   D ) Auto scaling  
   E ) API Gateway  
   F ) Blacklist some ip address 
   G ) RBAC
   H ) Statefulsets
   I ) Health Probes, Namespaces  
   J ) Community support etc

## How K8s solve this problems ??  
1) __Single Host System :__   
   By default K8s is a cluster means group of nodes  

   so when container A dies then k8s automatically assigns to another node because it supports multi node architecture , so 1st problem solved .. 


2) __Auto-Healing / Self-Healing :__  
     In k8s API Server is there when it receives a container is going down it rollout a new container before that container is going down. problem solved

3) __Auto-Scaling :__   
   In k8s we have Replicaset or Replication Controller yml files . In this YAML file we define replicas as 2 or 3 or n number as per requirement.   
    so whenever there is load increases then it automatically increases the number of containers as per the load if there is no load it decreases the number of containers . K8s supports HRA also .  

4) __Enterprise level Support :__   
 By default k8s supports the enterprise solutions with great community support.  

 -------  

 Finally __Kubernetes is a open source system for automated deployment, scaling and management of containerised applications.__