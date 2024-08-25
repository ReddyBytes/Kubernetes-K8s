
# Namespaces in Kubernetes (K8s)  
  NS are a way to divide cluster resources between multiple users or teams.we can organize and  isolate resources within a cluster.

![](https://miro.medium.com/v2/resize:fit:828/format:webp/1*VXnkCHS76XEKhCSR9nX87Q.png) 

## why Namespaces  ??
__1) Isolation :__ Namespaces allows isolation of resources, ensuring that users cannot interfere with each other's resources.  

__2) Resource Quotas :__ Administrators can define quotas for CPU, memory, and other resources within a namespace, controlling how much of the cluster's resources can be consumed by the applications running within that namespace.  

__3) RBAC (Role-Based Access Control) :__  Namespaces play a crucial role in RBAC, allowing administrators to define fine-grained permissions for accessing resources within a namespace.  

__4) Scope of Resources :__ Everything that can be named in Kubernetes, including Pods, Services, Deployments, ConfigMaps, and Secrets, is scoped within a namespace.  

### Types of Namespaces :  

__1) default :__ Used for objects created by users who haven’t specified a namespace.  

__2) kube-system :__ Contains objects created by the Kubernetes system.  

__3) kube-public :__ Automatically created and readable by all users (including those not authenticated).  

__4) kube-node-lease :__ we know thar when a pod goes down a new pod automatically comes .  
Used for service discovery and leader election for node heartbeats.


Additionally, users can create `custom namespaces` for organizing their applications and services.  

![](https://www.devopsschool.com/blog/wp-content/uploads/2023/10/image-47.png)



  
    kubectl create ns <namespace name>

In a clustere to list pods from a diff namspaces is difficult when we use `kubectl get pods -ns <namespace-name>`  . To avoid this we can use kubens binary .

To switch between namespaces.

### 1st way
  
    kubectl config set-context --current --namespace <namespace-name>


### 2nd way
#### setup of kubens in a cluster

step 1:  
   
      `cd /usr/local/bin/`

step 2:  copy the kubens latest release from [GitHub](https://github.com/ahmetb/kubectx/)  I'm using `V_0.9.5` for linux
  
    wget https://github.com/ahmetb/kubectx/releases/download/v0.9.5/kubens_v0.9.5_linux_x86_64.tar.gz

step 3 : remove the extension of kubens use below commands

    ls -al

    tar zxvf kubens_v0.9.5_linux_x86_64.tar.gz

    rm -rf kubens_v0.9.5_linux_x86_64.tar.gz

    ls -al


step 4 :  comeback and list namespaces 
  
    cd

    kubens  # to list all namespaces
    kubens <namespace name>  # to use that namespace
    