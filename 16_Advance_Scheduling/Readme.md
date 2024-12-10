
# **Advanced Scheduling in Kubernetes**

Advanced scheduling in Kubernetes allows you to place your pods on specific nodes in a cluster based on various conditions and rules. This is crucial for optimizing resource utilization, ensuring high availability, and achieving better performance and reliability.

### **Key Benefits of Advanced Scheduling**
1. **Better Resource Utilization**: Schedule pods on nodes that can handle their requirements efficiently.
2. **High Availability**: Spread critical workloads across multiple nodes.
3. **Custom Workload Placement**: Tailor scheduling to meet specific application needs.


## **1. Node Selector**
- Simplest form of node selection.
- Allows you to specify a single key-value pair to match node labels.
- It is a hard requirement—if no node matches the selector, the pod will remain unscheduled

#### **Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: node-selector-example
spec:
  nodeSelector:
    disktype: ssd
  containers:
    - name: nginx
      image: nginx
```

**Real-world Use Case:**  
You can schedule pods only on nodes with SSD storage for high I/O workloads.


## **2. Node Affinity**
- More advanced and flexible.
- Supports both hard requirements (requiredDuringScheduling) and soft preferences (preferredDuringScheduling) for node selection.


#### **Types of Node Affinity:**
1. **Required Node Affinity** `(requiredDuringSchedulingIgnoredDuringExecution)`

    - Similar to nodeSelector but supports complex rules like operators (In, NotIn, etc.).
    - If the rule isn't met, the pod won't be scheduled.

2. **Preferred Node Affinity** `(preferredDuringSchedulingIgnoredDuringExecution)`

    - Specifies a soft preference for scheduling.
    - If no matching nodes are available, the pod will still be scheduled on other nodes.

#### **Example:**
```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: disktype
          operator: In
          values:
          - ssd
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 1
      preference:
        matchExpressions:
        - key: zone
          operator: In
          values:
          - us-east-1

```

`Required:` Pod will only run on nodes with disktype=ssd.  
`Preferred:` If there are multiple nodes with disktype=ssd, it prefers nodes in the us-east-1 zone.



## **3. Taints and Tolerations**
Taints are applied to nodes to repel pods that don’t have matching tolerations. This ensures that only specific pods can run on those nodes.

#### **Example:**
**Taint a Node:**
```bash
kubectl taint nodes node1 key=value:NoSchedule
```

**Pod with Matching Toleration:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: toleration-example
spec:
  tolerations:
    - key: "key"
      operator: "Equal"
      value: "value"
      effect: "NoSchedule"
  containers:
    - name: nginx
      image: nginx
```

**Real-world Use Case:**  
Dedicated nodes for critical workloads like databases can be tainted to prevent non-essential pods from running there.


## **4. Pod Affinity and Anti-Affinity**

### **Pod Affinity**   
It is used to schedule pods close to other pods based on their labels. It ensures that certain pods are co-located on the same node or nodes in the same zone/rack.

__Use Cases:__  

1. **High Bandwidth/Low Latency Communication:** Useful for applications that need fast communication, such as microservices that frequently exchange data.
Shared Data Access: Ensures pods that share data are on the same node to reduce network overhead.  

2. **Cluster-aware Deployments:** Schedules pods near specific components like databases.

### Types
**Required Pod Affinity** `(requiredDuringSchedulingIgnoredDuringExecution):`  
- Specifies a hard requirement for pod placement.
- If the condition is not met, the pod will not be scheduled.

**Preferred Pod Affinity** `(preferredDuringSchedulingIgnoredDuringExecution):`

- Specifies a soft preference for pod placement.
- If the condition is not met, the pod can still be scheduled elsewhere. 


#### **Example:**
**Pod Affinity:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-affinity-example
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        labelSelector:
          matchExpressions:
            - key: app
              operator: In
              values:
                - frontend
        topologyKey: "kubernetes.io/hostname"
  containers:
    - name: nginx
      image: nginx

# Pods with the label app=frontend will be scheduled on the same node or nearby nodes (same hostname).

```

### **Pod Anti-Affinity**  
Pod Anti-Affinity is a feature that allows you to schedule pods away from other pods based on their labels. It ensures that pods are distributed across nodes to improve reliability and fault tolerance.

**Use Cases**

1. **High Availability**  
   - Ensures replicas of an application are spread across different nodes to reduce the risk of downtime during a node failure.

2. **Avoid Resource Contention**  
   - Prevents similar workloads from running on the same node to minimize competition for CPU, memory, and other resources.

3. **Multi-tenancy Isolation**  
   - Ensures that applications from different tenants or teams are not placed on the same node, maintaining logical and physical isolation.


**1. Required Pod Anti-Affinity (`requiredDuringSchedulingIgnoredDuringExecution`)**
- Specifies a **hard requirement** for pod placement.
- Pods **will not** be scheduled if the condition is not satisfied.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-anti-affinity-example
spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        labelSelector:
          matchExpressions:
            - key: app
              operator: In
              values:
                - frontend
        topologyKey: "kubernetes.io/hostname"
  containers:
    - name: nginx
      image: nginx
```
**2. Preferred Pod Anti-Affinity (`preferredDuringSchedulingIgnoredDuringExecution`)**  

Specifies a soft preference for pod placement.
Pods can still be scheduled if the condition is not met.  

```yaml
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 10
        podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: app
              operator: In
              values:
              - cache
          topologyKey: "kubernetes.io/hostname"

# This configuration indicates a preference to not schedule pods with the label app=cache on the same node, but the scheduler may ignore this preference if necessary.
```
**Real-world Use Case:**  
- Use **Pod Affinity** to place a backend pod close to a frontend pod for low-latency communication.  
- Use **Pod Anti-Affinity** to ensure replicas of a pod are spread across different nodes for fault tolerance.

---

### **Real-World Scenario**
Imagine running an e-commerce application with three components:
1. **Frontend Pods** need to run on SSD nodes for fast access to assets.
2. **Database Pods** require dedicated, high-memory nodes (taints and tolerations ensure this).
3. **Backend Pods** need to be located close to the frontend for faster communication (Pod Affinity).

