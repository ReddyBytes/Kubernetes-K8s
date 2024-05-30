## Kind Commands :  

1) To create a new cluster
  
      
        kind create cluster --name=reddybites  
2) To create multi node cluster  
    
        
        kind create cluster --name=multi-node --config=multi_node_cluster.yml  
3) To list all clusters
     
       
         kind get clusters  
4) To delete cluster  
     
       
         kind delete cluster --name=reddybites  

5) To list the nodes 
     
       
         kind get nodes  

6) by default kind automaticcaly assigns to the latest cluster if you face `connection refused error ` you need to change the cluster   
  To list all the clusters use   
       
         kubectl config view  
         kubectl config view | grep kind  
         kubectl config use-context <cluster-name>