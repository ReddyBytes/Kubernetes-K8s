# RBAC  ( Role Based Access Control ) :
To understand RBAC i divide them into 2 parts   
1) __Users :__   
   Based on the role and job description  of user/Engineer we will give permissions for to certain extend.

2) __Service Accounts :__  
   Based on the  kind/name of the service we will give permissions .
   lets say a pod can access secrets, configmaps, etc or not .  

### How RBAC Managing these Permisssions:
1) __Service Accounts/Users :__  
2) __Roles and RoleBinding :__  
   Define permissions within a namespace. A Role contains rules that represent a set of permissions. A RoleBinding grants the permissions defined in a role to a user or set of users.
3) __ClusterRoles and ClusterRoleBindings :__    
   Similar to Roles and RoleBindings but apply cluster-wide permissions, affecting all namespaces.  


### implementing of RBAC  
__step 1 :__ create a role to user  
__step 2 :__ BY using RoleBinding connect Role with users 

![](https://k21academy.com/wp-content/uploads/2020/10/Screen-Shot-2020-08-13-at-10.58.16-AM.png)  

![](https://www.middlewareinventory.com/wp-content/uploads/2022/11/k8s-rbac.jpeg)  

for more details visit official k8s [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) page