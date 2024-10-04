To know more commands [click here](https://kubernetes.io/docs/reference/kubectl/quick-reference/)

- to know the apiversion and kind of k8s object  
  
      
        kubectl api-resources | grep <k8s object name>

- port forwarding
   
       
         kubectl port-forward <k8s object name>/<name of the object> <new port>:<old port>

         kubectl port-forward service/nginx-clusterip 8083:8081  
- to check logs 
  
    
      kubectl logs <podid> -f


- to know more about k8s objects
  
    
      kubectl explain <obj-name>
      kubectl explain pod



- to know the details of the k8s object or any parameters inside object use below command   

```bash
kubectl explain <object name>
kubectl explain deployment.spec.strategy.rollingupdate
```
- to run a pod without creating yaml 

```bash
kubectl run <pod name> --image <image-name:version>
```
- to create deployment yaml in the termianl by using command  
  
```bash
kubectl create deployment <deployment name > --image <image name> --replicas <replica count> --dry-run -o yaml
```


- Expose pod to  external world

```bash
kubectl expose deployment <deployment name> --port <instance port> --target-port <container port> --type <service_type(ClusterIP, NodePort, LoadBalancer)>

Generally this target port is know the image owner only else we can see by describing the pod