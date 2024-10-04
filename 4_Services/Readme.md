# Services 
### What happens if there is no service  ??
 Imagine 100 users trying to access an application supported by 3 ReplicaSets __( 172.3.14.1, 172.3.14.2, 172.3.14.3 )__ (each managing Pods). If one Pod goes down due to some external reasons, a new pod comes up because of Auto Healing, with a new IP address __( 172.3.14.5 )__.   

 But here to access the same application is difficult because IP address was changed.  
 for this again we need to give the ip address to developers, QA teams, production which is difficult in real world scenarios.  

 ex: does google says indians access this IP address and USA peoples access this IP address like that, no right ??? To avoid this we use services 
 
Service offers   
#### 1 ) Load Balancer 
#### 2 ) Service Discovery
#### 3 ) Expose to External world
 
 
 # 1. Load Balancer ( LB )
 services are create on top of the deployment and act as LoadBalancer with help of kube-proxy  

LB transfers the request to all pods equally, by default LB follows `Round Robin` method/rule means thansfering requests to pod by pod in a cyclic way.  

 request came to service -----> services transfers to the application ip-address ----> get the response -----> tramsfers to the users. 

 see the image to get better clarity

![](https://miro.medium.com/v2/resize:fit:720/1*LFMMBlUysm87TjdHlrlMTQ.jpeg)

# 2. Service Discovery  ( SD ):

### Again we have a doubt that even how Services knows that the request is to transfer to a particular appication if there is a change in IP-address : 

here service does not depends on IP-address, it follows `Service Discovery` mechanism 

SD creates  
`Labels` &   `Selectors` 

when a new pod comes up with template then service always checks for label name not the ip address
  
 ```yaml  
apiVersion: apps/v1
kind: Deployment
metadata:
    name: nginx-deployment
    labels:
        name: deployment-dev
spec:
    replicas: 3
    selector:
        matchLabels:
            app: nginx
    template:
        metadata:
            labels:
                app: nginx
        spec:
            containers:
            - name: nginx
                image: nginx:1.14.2
                ports:
                - containerPort: 80
```

container >> pod >> deployment >> services   

Here  we gave deployment selector as `nginx` so  if any pod with that label `nginx` comes under this deployment. lly this deployment label is `deployment-dev` so any service with selector as `deployment-dev`. so this deployment will go under that service and applies those service rules to this deployment .
# 3. Expose to External World

service will expose application to outside world to access users from different locations  

we can expose our application to external world in 3 ways   

### __1) Cluster IP :__    
- Application can be accessed within the cluster only. Means users can access when they know the cluster IP address . 
- simply say the persons in  a team can access this application.
- ClusterIP is capable to route the requests to all pods by following `Round Robin ` method.

![](/images/clusterip.png)

#### multiport 
![](/images/multiport.png)

### __2) NodePort  :__  
- Users can access only when they know the Node IP address (EC2 instance) and the Node port . Those people can access the application. `Node-IPaddress:Node-Port`
- Node port ranges from 30000-32767
- This Nodeport internally sends request to clusterIP only then clusterip contacts to pods.  

externalrequest >> receives by NodePort >> request sends to ClusterIP >> request sends to pod >> container >> response in same direction  

![](/images/nodeport.png)
 

### __3) Load Balancer  :__ 
- Access to everyone in the world by using DNS name like www.amazom.com , google.com, etc .   
- CCM give a public ip address and this ip address is rigistered in DNS. This DNS will give the name. so that user can access by name not with IP address.


![](https://miro.medium.com/v2/resize:fit:1400/0*oIZ93q4u-Sx9DT5E.JPG  )  


![](https://i.octopus.com/blog/2022-11/difference-clusterip-nodeport-loadbalancer-kubernetes/loadbalancer.png)  

![](https://matthewpalmer.net/kubernetes-app-developer/articles/service-annotated.png)

Generally this target port is know the image owner only else we can see by describing the pod