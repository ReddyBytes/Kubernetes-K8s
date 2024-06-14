- to know the apiversion and kind of k8s object  
  
      
        kubectl api-resources | grep <k8s object name>

- port forwarding
   
       
         kubectl port-forward <k8s object name>/<name of the object> <new port>:<old port>

         kubectl port-forward service/nginx-clusterip 8083:8081  
- to check logs 
  
    
      kubectl logs <podid> -f


