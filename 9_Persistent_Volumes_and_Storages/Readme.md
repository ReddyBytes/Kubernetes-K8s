# Volumes in K8s : 
### Problems that we face before Volumes 
__1. No Durable Storage__  
Containers are temporary. Without PVs, data didn't last after containers stopped.  


__2. Manual Work__  
Admins had to set up storage outside Kubernetes and attach it manually.  

__3. Limited Choices__  
Developers couldn't easily switch between different storage types or locations.    

__4. Hard to Scale__  
Increasing storage needed manual effort and understanding of the storage system.   

__5. Security Issues__  
Keeping data safe was tough without automatic security settings.   

__6. Backup & Recovery__  
Making backups and recovering data was complicated due to the ephemeral nature of containers.  

__7. Sharing Data Difficulties__  
Sharing data between different parts of an application or between different applications was hard without a centralized storage solution.  

__8. Persisting Data Across Container Lifecycles__  
Storing data that needed to be available even after a container restarted or crashed was challenging.  

![](/images/volumes.png)  


## Types of Volumes
### 1 . Persistent Volumes ( PV ) :  
It is like a a piece of storage on host machine where we link our container data to  this volume , so that when a container lost we don't loss data .   

When we create a PV in Kubernetes, we’re essentially saying, “I need a storage space that will last even if my pod is restarted.”

1. Persistent Volume (PV) is created and set up by an administrator.
2. It exists independently of the pods and keeps data safe, even when no pods are using it.
3. Think of it like a USB drive that you can plug into any computer to save your files.

###  Types of Persistent Volume

a. `local –` Data is stored on devices mounted locally to your cluster’s Nodes.  

b. `hostPath –`  Stores data within a named directory on a Node (this is designed for testing purposes and doesn’t work with multi-Node clusters).  

c. `nfs –` Used to access Network File System (NFS) mounts.  

d. `iscsi –` iSCSI (SCSI over IP) storage attachments.  

e. `csi –` Allows integration with storage providers that support the Container Storage Interface (CSI) specification, such as the block storage services provided by cloud platforms.  

f. `cephfs –` Allow the use of CephFS volumes.  

g. `fc –` Fibre Channel (FC) storage attachments.  

h. `rbd –` Rados Block Device (RBD) volumes.  

### Provisioning of PersistentVolumes

__1. Static__  
In static provisioning, the cluster administrator creates PVs with details of available storage. These PVs are pre-defined in the Kubernetes API and are ready for use by cluster users. And if the developers want an additional volume we can't get because the static PV are predefined. 

__2. Dynamic__  
In dynamic provisioning, when no static PV matches a user’s PersistentVolumeClaim (PVC), the cluster can automatically provision a volume.Means developers/Users can get additional storage also, in the backend the volume is created as Dynamic PV.   

![](https://www.researchgate.net/publication/368281482/figure/fig4/AS:11431281117874688@1675566270775/PV-and-PVC-relationship-diagram.png
)

 ### 2 . Persistent Volume Claims ( PVC ) : 
 A Persistent Volume Claim is like a “request” for a storage box. When an app or pod needs some space to store data, it doesn’t get to just grab any PV. Instead, it creates a PVC to ask for a specific amount of space. Kubernetes then looks for a PV that can satisfy this claim.

- PVC is like a shopping list saying, “I need this much space and certain features (like speed or type).”
- Kubernetes matches the PVC to a PV that meets the request.
- Once a PVC finds a PV, they are connected, and the pod can use that storage as long as it needs it.


 ![](https://miro.medium.com/v2/resize:fit:877/1*hYuhPT326a55b4Vf7LkJJQ.png)  

 ## Ephemeral Volumes  
Ephemeral volumes do not store data persistently across restarts. These volumes are bound to the pod's lifetime, which means they are created and deleted along with the pod  

### 1. EmptyDir Volumes  
- An emptyDir volume is created when Kubernetes assigns a pod to a node.   
- The lifespan of this volume is tied to a pod's lifecycle existing on that specific node.  
-  An emptyDir volume recreates when containers restart or crash.  
-  The data in this volume is deleted and lost when the pod is removed from the node, crashes, or dies  
  

### 2. HostPath Volumes  
A hostPath volume mounts a directory or file from the host node's filesystem into your pod.  
Ex : Using HostPath for reading log files from the host for debugging.  

![](https://miro.medium.com/v2/resize:fit:799/1*34_SfcEcC9guWzfQkEtbpQ.png)  

## Features of volumes

### 1. Access Modes
__ReadOnlyMany(ROX)__ allows being mounted by multiple nodes in read-only mode.  

__ReadWriteOnce(RWO)__ allows being mounted by a single node in read-write mode.  

__ReadWriteMany(RWX)__ allows multiple nodes to be mounted in read-write mode.  

A volume can only be mounted using one access mode at a time, even if it supports many access modes.


### 2. Reclaim Policy
When the node no longer needs persistent storage, the reclaiming strategies that can be used include:

__Retain -__ meaning the PV, until deleted, is kept alive.  
__Recycle -__ meaning the data can be restored later after getting scrubbed(cleaning or erased).  
__Delete -__ associated storage assets (such as AWS EBS, GCE PD, Azure Disk, and OpenStack Cinder volumes) are deleted.   



