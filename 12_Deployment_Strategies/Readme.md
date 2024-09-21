Here we can learn the most important Deployment Strategies that the enterprises follows:

__Why we need this strategies for deploymens ?__
    
Lets say `RAPIDO` application has an deployment with 4 replicasets with V1. After few months they updated the application with new features as V2 and they want to deploy this . If they delete the V1 replicas and install the new V2 replicas will takes atmost 10 min called downtime. Which may cause revenue loss and users discomfort in that 10 min. So to bring this downtime to `ZERO` we need to follow some strategies as stated below.


1. Rolling Update Deployment
2. Canary Deployment
3. Blue-Green Deployment


## 1. Rolling Update Deployment :

This is the `Default` Deployment that kubernetes providing. 
In this Deployment 25% of new version Pods(RS) will deploy and 25% of old versions pods will terminate.

The 2 main parameters we need to follow in this deployment are  
`1. max unavailable :`  The maximum number of pods that are unavailable during deployment (default 25%). If needed we set replica count also as 1/2 pods need to be unavailable .  

`2. max surge :` How many new version pods need to be deployed (default 25%).  

And make sure that Readinessprobe is configured in your cluster so that whenever the new updated pod is ready to handle the request then k8s transfers to that pod.  

![](https://www.golinuxcloud.com/wp-content/uploads/rollingupdate-1.jpg)

__So, what is happening here?__

- In this case, one replica can be unavailable, so since the desired replica count is 4, only 3 of them need to be available.
- That’s why the rollout process immediately deletes one pod and creates one new Pod because maxSurge is defined as 1 so anytime we can have a maximum of 4 pods.
- This ensures 3 pods are available at minimum and that the maximum number of pods isn’t exceeded.
- As soon as the new pod is available, the next pod is terminated and a new pod is started with the updated image.
- This will continue until all the pods are running with updated nginx image.  

Try this strategy : 

        kubectl create deploy <deployment_name> --image=<image_name>  

        kubectl get pods
        
        kubectl edit deploy <deployment_name>  # change replicas count  

        kubectl get pods --watch  # in another terminal and check the pods creating and terminating

        kubectl edit deploy <deployment name> # now give non-exist image name  

        kubectl get pods --watch  # in another terminal and check the pods creating and terminating here you can see IMAGEPULLBACKERROR for new versions.


## 2. Canary Deployment :


**Canary deployment** is a way to gradually roll out a new version of application to a small group of users before releasing it to everyone. This helps us to test the new version in a real environment, catch any issues early, and prevent full system failure if something goes wrong.

`EX :` Instagram , PUBG, Twitter etc. application will test new features to small amount of customers at initially called `Beta version`. If the users statisy then they will realse `stable version` means LB routes all requests to new version pods.
#### How Does It Work?

1. **Start with the stable version**: Your current application version (e.g., v1.0) is running smoothly in production.

2. **Deploy the canary version**: Deploy new version (e.g., v2.0) to handle a small percentage of traffic (e.g., 10%). All the traffic transfer will take care by Load Balancer(so 90% of users can access old version and 10% of users access new version)
3. **Monitor performance**: Watch the canary version closely. If everything works fine, increase the traffic. If problems occur, roll back the new version.
4. **Gradual rollout**: Slowly increase the number of users on the new version until it fully replaces the old version.

#### Why Use Canary Deployment?

- **Minimize Risk**: Only a small part of your system is exposed to potential issues with the new version.
- **Quick Rollback**: If the new version fails, it can easily be replaced with the old version.
- **Real-World Testing**: Canary deployments let you test in a real environment with real users before going fully live.


TRY this deployment :

1. install nginx controller for LB 
                
        minikube addons enable nginx   

2.  verify that controller is installed or not  
            
        kubectl get pods -A   

3. open this [canary page](https://kubernetes.github.io/ingress-nginx/examples/canary/) and create the deployment , service, ingress for v1(main) and v2(canary)  `OR` just use apply command `kubectl apply -f <file name>` for both [main](/12_Deployment_Strategies/main_deployment_v1.yml) and [canary deployment](/12_Deployment_Strategies/canary_deployment_v2.yml) files.

4. Get the IP address of minikube

        minikube ip

        minikube ssh  # login into minikube cluster

5. execute the below command to send requests . change the minikube address

        for i in $(seq 1 10); do curl -s --resolve echo.prod.mydomain.com:80:$MINIKUBE_IP_ADDRESS echo.prod.mydomain.com  | grep "Hostname"; done

6. Then update the canary ingress for 50% of traffic routes to new version . Then apply step 5




---
## 3. Blue Green deployment


**Blue-Green Deployment** is a release management strategy that runs two separate environments, one for the current (stable) version (called **Blue**) and one for the new version (called **Green**). Traffic is routed to either environment, and the switch between them is quick and seamless. This minimizes downtime and allows for easy rollback if issues occur with the new version.



#### How Does Blue-Green Deployment Work?

1. **Two Identical Environments**:
   - **Blue Environment**: The currently running version of the application, stable and handling all live traffic.

   - **Green Environment**: The new version that you want to deploy. It runs alongside the blue environment but doesn't receive any traffic yet.

2. **Testing the Green Environment**:
   - Once the green environment is set up with the new version, it's tested thoroughly to ensure it works as expected.
   
3. **Traffic Switch**:
   - If the green environment passes all tests, traffic is switched from the blue environment to the green one.
   
4. **Blue Becomes Backup**:
   - After the traffic switch, the blue environment remains in place as a backup. If any issues arise with the green environment, you can easily switch traffic back to the blue environment.
   
5. **Clean-up**:
   - Once you're confident in the new version, the blue environment can be taken down or updated to be ready for the next deployment cycle.


#### Benefits of Blue-Green Deployment

- **Zero Downtime**: Traffic is switched instantly from blue to green, ensuring no downtime during deployment.

- **Easy Rollback**: If something goes wrong with the green environment, it's easy to switch back to the blue environment. Means we need to change the service name in the Load Balancer.

- **Seamless Transitions**: Users experience a smooth transition between versions without interruptions.

- **Test in Production**: The green environment is live but isolated from users, allowing real-world testing.


