# ConfigMaps and Secretes  

These are like .env files which stores env varibles like password,username etc., In k8s we store such type of information in configmaps.  
And more sensitive information will store in secrets file these are encrypted . and we can do customizations and can give strong RBAC protection.

Both Configmaps and secrets are stored in etcd but secrets are stored in encrypted format

![](https://miro.medium.com/v2/resize:fit:1400/1*TxFP9sw9T_Me_UfTvT8eEw.png)  


![](https://miro.medium.com/v2/resize:fit:1160/0*doaioRB-9pQ-Hy21)  

we cant change env variables inside the container even if u update the env variables in configmaps container wont change these vaibles to new one . This will leads us probles in production .

to update the env variables in running container __VolumeMounts__ came to solve this problem   

### Secrets
![Secrets](https://www.padok.fr/hubfs/Images/Blog/kubernetes-secret-management-process.png)