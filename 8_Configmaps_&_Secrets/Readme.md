# ConfigMaps and Secretes  

These are like .env files which stores env variables like password,username etc., In k8s we store such type of information in configmaps.  
And more sensitive information will store in secrets file these are encrypted . and we can do customizations and can give strong RBAC protection to secrets

Both Configmaps and secrets are stored in etcd but secrets are stored in encrypted format

![](https://miro.medium.com/v2/resize:fit:1400/1*TxFP9sw9T_Me_UfTvT8eEw.png)  


![](https://miro.medium.com/v2/resize:fit:1160/0*doaioRB-9pQ-Hy21)  

we cant change env variables inside the container even if u update the env variables in configmaps container wont change these vaibles to new one . This will leads us probles in production .

to update the env variables in running container __VolumeMounts__ came to solve this problem   

### Secrets
![Secrets](https://www.padok.fr/hubfs/Images/Blog/kubernetes-secret-management-process.png)


### Types of secrets :


Kubernetes supports several types of secrets, each designed for different use cases. Below is a detailed explanation of the most common secret types.

| **Secret Type**                           | **Purpose**                                                                                                                                                             | **Details**                                                                                                                                             |
|-------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Opaque**                                | General-purpose secret for arbitrary key-value pairs.                                                                                                                    | This is the default type for user-defined secrets. It can store arbitrary data such as API tokens, passwords, or other sensitive information.             |
| **kubernetes.io/service-account-token**   | Contains a service account token for authenticating with the Kubernetes API.                                                                                             | Automatically created by Kubernetes when you create a ServiceAccount. Allows pods to communicate with the Kubernetes API securely using the token.        |
| **kubernetes.io/dockercfg**               | Stores Docker credentials in the `.dockercfg` format.                                                                                                                    | Used for authenticating with Docker registries. Contains credentials to pull private images. Deprecated in favor of `kubernetes.io/dockerconfigjson`.     |
| **kubernetes.io/dockerconfigjson**        | Stores Docker credentials in the `.dockerconfigjson` format.                                                                                                             | This is the preferred method for storing Docker credentials. The secret is used to authenticate to Docker registries when pulling private container images.|
| **kubernetes.io/basic-auth**              | Stores basic authentication credentials (username and password).                                                                                                         | Stores HTTP basic authentication credentials. Typically used for services that require basic authentication over HTTP.                                    |
| **kubernetes.io/ssh-auth**                | Stores SSH private keys for SSH-based authentication.                                                                                                                    | Useful for storing private keys needed for SSH authentication, such as accessing a remote server or Git repositories.                                     |
| **kubernetes.io/tls**                     | Stores TLS certificates and private keys for SSL/TLS termination.                                                                                                        | Used for managing TLS certificates. It stores a certificate and its associated private key, typically for HTTPS or other secure communication.           |
| **bootstrap.kubernetes.io/token**         | Stores tokens used for bootstrapping nodes into the cluster.                                                                                                             | This secret type stores bootstrap tokens used by kubeadm to join new nodes into the cluster.                                                              |
| **helm.sh/release.v1**                    | Stores Helm release data.                                                                                                                                                 | Created by Helm for managing releases of Helm charts. It includes metadata about Helm chart deployments and is automatically generated by Helm during installation or upgrade processes.|


#### Service Account: 
- A Service Account in Kubernetes is an identity used by pods to authenticate with the Kubernetes API and other services to make secure API calls without relying on user credentials.

- some of the usecases where pods make API calls
    -  Reading or writing ConfigMaps, Secrets, or other resources.
    - Monitoring or interacting with cluster nodes, deployments, and more.


- When a pod is created, if no service account is explicitly specified, it automatically uses the default service account of the namespace.

- The service account's secret (which contains the API token, CA certificate, and namespace details) is mounted inside the pod, usually at `/var/run/secrets/kubernetes.io/serviceaccount`. 

- In Airflow on Kubernetes, 
    - task might require access to the Kubernetes API to monitor the status of other resources like deployments or pods.
    - Additionally, you could create a custom service account with specific Role-Based Access Control (RBAC) permissions for enhanced security, restricting access only to the necessary API endpoints that Airflow needs.