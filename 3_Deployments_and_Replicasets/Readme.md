# Deployments :

### As we have pods for deploying then why we need deployment for deoploying ???
Auto healing, auto scaling and zero down time features are not supported in pods . so that we move from pods to deployments .  finally we deploy only pods  but by using Deployment resource.

These features are implemneted by Replicasets  (controller)

Deployment creates -----> Replicasets  creates -----> pods  

![](https://storage.googleapis.com/cdn.thenewstack.io/media/2017/11/07751442-deployment.png)
## Why deployments: 

__1.  High Availability & Scalability :__ Deployments ensure a specified number of Pod replicas are always running, for easy scaling based on demand.

__2. Smooth Updates :__ They enable rolling updates, allowing applications to be updated with minimal downtime.

__3. Fault Tolerance :__ With Deployments, Kubernetes can automatically replace failed Pods, enhancing the overall  reliability of applications. 

for more info [---->](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)  


## Pod vs Container vs Deployment

| Concept         | Key Point 1                                                                 | Detailed Explanation                                                                                     | Key Point 2                                                                 | Detailed Explanation                                                                                     | Key Point 3                                                                                   | Detailed Explanation                                                                                   |
|-----------------|----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| **Containers** | Isolation                                                                          | Containers are isolated from each other and the host system, ensuring that processes running in one container do not interfere with those in another. This isolation allows for secure and predictable behavior of applications. | Portability | Containers can run anywhere that has a Linux kernel, making them highly portable across different environments. This portability simplifies deployment and scaling of applications. | Efficiency | Containers share the host system's OS kernel but run in isolation from each other, leading to better resource utilization compared to virtual machines. This efficiency is achieved without sacrificing security or isolation. |
| **Pods**       | Grouping                                                                          | A Pod is a group of one or more containers that share storage/network resources and a specification for how they should run. This grouping allows for co-located containers to communicate with each other using `localhost` and share storage volumes. | Network | All containers within a Pod share the same network namespace, allowing them to communicate with each other using `localhost`. This setup simplifies networking for applications that consist of multiple interconnected containers. | Lifecycle Management | Pods are ephemeral and portable, making it easier to manage applications as a cohesive unit. When a Pod is deleted, its containers are also deleted, and a new Pod can be created to replace it. This lifecycle management facilitates dynamic scaling and updating of applications. |
| **Deployments**| Managing Replicas                                                                | Deployments ensure that a specified number of Pod replicas are running at any given time, providing high availability. This managed replication helps in maintaining the desired state of applications even in the face of failures. | Rolling Updates | Deployments support rolling updates, allowing applications to be updated with minimal downtime. By gradually replacing old Pods with new ones, Deployments ensure that the application remains available throughout the update process. | Scaling | Deployments can scale applications up or down by adjusting the number of Pod replicas, responding to changes in demand. This scalability feature allows for automatic adjustment of resources based on current workload, optimizing resource usage and cost. |


## Replicasets
RS is the controller that implements the Auto Healing functionality  

### Key Features
__1. Maintaining Desired State :__ ReplicaSets ensure that a certain number of pod instances are running at all times. If a pod goes down or is deleted, the ReplicaSet creates a new one to maintain the count.  

__2. Scaling :__ By adjusting the number of replicas, ReplicaSets allow for scaling applications up or down based on demand.  

__3. Rolling Updates :__ As part of Deployments, ReplicaSets support rolling updates, gradually replacing old pod instances with new ones to minimize downtime