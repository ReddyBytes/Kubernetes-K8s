## Installation of minikube: 
__step 1:__ Go to this [link](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download) and download the latest version as per ur system os . 

__step 2 :__ start the minikube cluster  
  
    minikube start

    minikube start -p custom-cluster

__step 3 :__ install kubectl from [here](/kind_installation/kind_installation_guide.md#kind-installation-)  




### commands

- to know the node ip address  
  

        minikube ip -p local-cluster

        minikube service <service name> -p local-cluster 

- to list the clusters 
  
    
      minikube profile list 


- use the custom cluster 
  
    
      kubectl config use-context <custom-cluster>  

- to know that which cluster u r using  
  
    
      kubectl config current-context