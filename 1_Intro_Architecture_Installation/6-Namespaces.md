
Namespaces in Kubernetes (K8s) are a way to divide cluster resources between multiple users or teams. They provide a scope for names of resources, allowing you to organize and isolate resources within a cluster. Namespaces are similar to Linux namespaces and are a core aspect of Kubernetes' multi-tenancy model.

Key Concepts of Namespaces
Isolation: Namespaces allow for isolation of resources, ensuring that users cannot interfere with each other's resources.
Resource Quotas: Administrators can define quotas for CPU, memory, and other resources within a namespace, controlling how much of the cluster's resources can be consumed by the applications running within that namespace.
RBAC (Role-Based Access Control): Namespaces play a crucial role in RBAC, allowing administrators to define fine-grained permissions for accessing resources within a namespace.
Scope of Resources: Everything that can be named in Kubernetes, including Pods, Services, Deployments, ConfigMaps, and Secrets, is scoped within a namespace.
Types of Namespaces
Kubernetes defines several built-in namespaces for system components and default usage:

default: Used for objects created by users who haven’t specified a namespace.
kube-system: Contains objects created by the Kubernetes system.
kube-public: Automatically created and readable by all users (including those not authenticated).
kube-node-lease: Hosts Lease objects used by the Kubernetes node lease mechanism for leader election.
Additionally, users can create custom namespaces for organizing their applications and services.