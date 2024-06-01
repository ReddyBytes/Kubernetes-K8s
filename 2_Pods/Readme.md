# Pods
1) In k8s lowest deployment is pod  
2) pod describes the definition of how to run a container
3) pod is nothing but a wrapper around container  
4) pod can have multiple containers called __sidecar containers__

## Characteristics
**Functionality :** To run applications or processes in a cluster.
__Ephemeral :__ Pods are temporary and can be replaced.  
__Container Sharing :__ Containers within a Pod share the same network namespace.  
__Resource Limits :__ Allow specifying CPU/memory usage limits per container.
__Networking :__ Containers use the Pod's IP for internal communication.  
__Storage :__ Supports shared volumes for data persistence.

In docker we run a container and giving a command docker run -d , -p ,--name, --network ,--link  all in terminal where as in pod we give this in a YAML file because k8s dealss with only yaml file 

![](https://media.geeksforgeeks.org/wp-content/uploads/20230418171834/Kubernetes-pods-architecture-for-Kubernetes-pod.webp)


find more yml files for pods from [here](https://k8s-examples.container-solutions.com/examples/Pod/Pod.html) 