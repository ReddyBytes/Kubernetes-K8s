# INGRESS :

### Problems faced before Ingress :

Ingress came after dec 2015. how the workflow is working before ingress.  
Services offers us to expose our application to external world. In services we are using simple __Round Robin__ Load balancer.  

But the organizations came from VMs to Kubernetes they face some problems like   

__Problem 1 :__  Traditional LB of VMs offers features lke   
1) __Ratiobased load balancing__  ( 40% to service 1,20% to service 2 etc )
2) __sticky sessions__  (Cookies)
3) __path based LB__  (example.com/home, example.com/welcome)  
4) __Host based LB__  ( .com, .in )
5) __Domain based LB__  (`www.example.com` general web browsing,`store.example.com`  servers configured for e-commerce transactions,) 
6) __White listing ip address__
7) __Blacklisting IP address__  
8) __Web Application Firewall__  
9) __TLS__  ( data transmitted between systems remains private and integral)  etc., 

 These features won't be available in k8s at initial days.  

 __Problem 2 :__ In k8s to expose our application we use  service LB  but here Cloud Provider charges for every IP address which costs alot .  
 __for ex :__ Amazon has so many microservices for each service they need one ip address which costs significantly high.

### How Ingress solve this problems ??
Kubernetes came with a sol called Ingress Controllers ( ntg but an NLB ) on the top of Service. based on our requirement we can select multiple controllers provided by diff organizations namely

1) nginx  
2) f5  
3) Ambassador 
4) HA proxy
5) Traffic  

These companies will provide controllers code in github and steps to implement as the devops teams we need to implement these controllers along with ingress by using [Helm charts](/1_Intro_Architecture_Installation/5-HelmCharts.md) or [YAML files](/1_Intro_Architecture_Installation/4-YAML-files.md)   


![](/images/ingress.png)
![](https://miro.medium.com/v2/resize:fit:2000/1*AgWCYOe3yMevVfzT_1EHog.png)  


Know more about [ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)



## Installation of Ingress Controller ???
to enable ingress functinality we need to install ingress controller depends on our requirement [here](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) you can find all ingress controllers available as of now. 

here i am installing nginx controller for minikube [see documentation](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/)  
  
    minikube start --vm=true -p ingress-cluster

    minikube addons enable ingress -p ingress-cluster

    




### yaml file

![](/images/ingress-pathtype.png) 

1) apply the simple-nginx.yml file
2) get the ip address of minikube use 

        minikube ip -p <cluster name>

3) sudo vi /etc/hosts

         # add your minikube ip with  host namein your yaml like 
         vi /etc/hosts

         192.168.53.28 nginx-demo.com

4) access your application from browser by using host

