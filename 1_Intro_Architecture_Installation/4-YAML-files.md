## YAML file
A YAML (YAML Ain't Markup Language). It is a human-readable data serialization standard used in configuration files,  

### Why we need ???
- YAML is known for its readability and simplicity.
- It supports complex data structures efficiently.
- Being language-agnostic, it's versatile across different platforms.
- Ideal for creating clear and manageable configuration files.
- Facilitates easy data exchange between applications.
- Allows for direct inclusion of comments within the file.
- Has extensive library support in various programming languages.

see the difference between YAML, JSON, XML  
![](https://www.cyberfella.co.uk/wp-content/uploads/2020/04/xml-json-yaml-1024x273.png)

## YAML in Kubernetes  




### Table of Contents
- [Basic Parameters](#basic-parameters)
- [Pod and Container Parameters](#pod-and-container-parameters)
- [Deployment and ReplicaSet Parameters](#deployment-and-replicaset-parameters)
- [Service Parameters](#service-parameters)
- [ConfigMap and Secret Parameters](#configmap-and-secret-parameters)
- [Volume and Storage Parameters](#volume-and-storage-parameters)
- [Advanced Parameters](#advanced-parameters)

---

## Basic Parameters

### `apiVersion`
Specifies the API version of Kubernetes being used (e.g., `v1`, `apps/v1`).
```yaml
apiVersion: apps/v1
```

### `kind`
Defines the kind of resource (e.g., `Pod`, `Service`, `Deployment`).
```yaml
kind: Deployment
```

### `metadata`
Contains metadata about the object, including the name, labels, annotations, etc.

- **`name`**: The name of the resource.
  ```yaml
  metadata:
    name: my-deployment
  ```
- **`namespace`**: The namespace in which the resource exists (optional).
  ```yaml
  metadata:
    namespace: my-namespace
  ```

- **`labels`**: Key-value pairs to tag the resource.
  ```yaml
  labels:
    app: myapp
  ```

- **`annotations`**: 
  - Key-value pairs for attaching metadata to objects (non-identifying).
  - Annotations allow you to add additional context or metadata to your Kubernetes objects. They are often used for:

  - **Documentation:** Providing additional context or descriptions about a resource.
  - **Debugging:** Storing information about when and how an object was modified.
  - **Automation:** Tools and controllers can use annotations to make decisions or store metadata (e.g., deployment history, build information).
  - **Configuration:** Some Kubernetes features or external services rely on annotations to configure behavior (e.g., ingress controllers, logging, monitoring).
  - **Tracking metadata:** Storing references like the last-applied configuration for auditing or debugging purposes.
  ```yaml
  metadata:
  name: my-pod
  annotations:
    description: "This pod runs the backend service."
    createdBy: "admin"
    deploymentDate: "2024-09-30"
    checksum/config: "d23f5f57a8ff1e5b1b7c917d9f8e6d93"
    kubectl.kubernetes.io/last-applied-configuration: "..."  # to store last kubectl apply confisuration changes
    nginx.ingress.kubernetes.io/rewrite-target: /   # ingress controller configuration
    prometheus.io/scrape: "true"
    prometheus.io/path: "/metrics"
    prometheus.io/port: "9090"    # monitering tool configuration
  ```

---

## Pod and Container Parameters

### `spec`
The `spec` field contains the specification for the resource, which can include details about pods, containers, services, volumes, etc.

### **Pod Templates**
Defines how pods should be created. The pod template is part of the `spec` in resources like Deployments and ReplicaSets.

```yaml
spec:
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: my-container
        image: nginx:latest
```

### **Containers**
Defines the list of containers to run in the pod.

- **`name`**: Name of the container.
- **`image`**: Container image to be used.
  ```yaml
  containers:
  - name: my-container
    image: nginx:latest
  ```

- **`ports`**: List of ports to expose from the container.
  ```yaml
  ports:
  - containerPort: 80
  ```

- **`env`**: Environment variables for the container.
  ```yaml
  env:
  - name: ENVIRONMENT
    value: "production"
  ```

- **`resources`**: Specifies resource limits and requests (e.g., CPU, memory).
  ```yaml
  resources:
    requests:
      memory: "64Mi"
      cpu: "250m"
    limits:
      memory: "128Mi"
      cpu: "500m"
  ```

### **Readiness & Liveness Probes**
Used to check if a container is healthy and ready to accept traffic.

- **`livenessProbe`**: Defines the action to check if a container is alive.
  ```yaml
  livenessProbe:
    httpGet:
      path: /healthz
      port: 8080
    initialDelaySeconds: 3
    periodSeconds: 10
  ```

- **`readinessProbe`**: Defines the action to check if the container is ready.
  ```yaml
  readinessProbe:
    httpGet:
      path: /readyz
      port: 8080
    initialDelaySeconds: 5
    periodSeconds: 10
  ```

### **ImagePullPolicy**
Determines when Kubernetes pulls the image for a container (`Always`, `IfNotPresent`, `Never`).
```yaml
imagePullPolicy: Always
```

---

## Deployment and ReplicaSet Parameters

### **Replicas**
Defines the number of desired pod replicas.
```yaml
replicas: 3
```

### **Strategy**
Defines the deployment strategy (`RollingUpdate`, `Recreate`).

- **`type`**: Defines the type of strategy.
  ```yaml
  strategy:
    type: RollingUpdate
  ```

- **`maxSurge`**: The maximum number of pods that can be created above the desired amount.
- **`maxUnavailable`**: The maximum number of pods that can be unavailable during the update process.

```yaml
strategy:
  rollingUpdate:
    maxSurge: 25%
    maxUnavailable: 25%
```

### **MinReadySeconds**
Specifies the minimum time a pod must be ready before it is considered as available. It is useful during Rollingupdate deployment. so that after passing readiness probe then pod waits to complete this minReadySeconds thenonly k8s treates pod as available.
```yaml
minReadySeconds: 10
```

### **Selector**
Specifies which pods are targeted by the deployment based on their labels.
```yaml
selector:
  matchLabels:
    app: myapp
```

---

## Service Parameters

### **Type**
Defines the type of service (`ClusterIP`, `NodePort`, `LoadBalancer`).

```yaml
spec:
  type: LoadBalancer
```

### **Ports**
Defines the port mappings for the service.

```yaml
ports:
- port: 80
  targetPort: 8080
  protocol: TCP
```

### **Selector**
Specifies the label used to target pods for the service.

```yaml
selector:
  app: myapp
```

---

## ConfigMap and Secret Parameters

### **ConfigMap**
Used to pass configuration data in the form of key-value pairs to pods.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  key1: value1
  key2: value2
```

### **Secret**
Used to store sensitive information like passwords, tokens, and keys. It can be referenced by pods.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  username: <base64_encoded_value>
  password: <base64_encoded_value>
```

---

## Volume and Storage Parameters

### **Volumes**
Defines volumes that are mounted to pods.

```yaml
volumes:
  - name: my-volume
    emptyDir: {}
```

### **VolumeMounts**
Specifies where the volume should be mounted in the container.

```yaml
volumeMounts:
  - mountPath: /data
    name: my-volume
```

---

## Advanced Parameters

### **Affinity and Anti-Affinity**
Defines rules for pod scheduling based on pod and node affinity.

- **Node Affinity**: Specifies rules for scheduling pods onto specific nodes.
- **Pod Affinity/Anti-Affinity**: Specifies rules for co-locating or separating pods.

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
  podAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 100
      podAffinityTerm:
        labelSelector:
          matchExpressions:
          - key: app
            operator: In
            values:
            - myapp
```

### **Tolerations**
Defines conditions under which a pod can be scheduled to nodes with matching taints.

```yaml
tolerations:
- key: "key1"
  operator: "Exists"
  effect: "NoSchedule"
```

### **Node Selector**
Specifies labels that a node must have for a pod to be scheduled onto it.

```yaml
nodeSelector:
  disktype: ssd
```

### **Horizontal Pod Autoscaling (HPA)**
Enables autoscaling of pods based on resource usage like CPU or memory.

```yaml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: myapp-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 80
```

---

### **TerminationGracePeriodSeconds**
Specifies the time to wait for a pod to gracefully shut down before forcibly terminating it.

```yaml
spec:
  terminationGracePeriodSeconds: 30
```

### **Init Containers**
Defines containers that run before the main containers to perform setup tasks.

```yaml
initContainers:
- name: init-myservice
  image: busybox
  command: ['sh', '-c', 'echo init container']
```

### **PriorityClassName**
Specifies the priority of a pod when scheduling compared to others.

```yaml
spec:
  priorityClassName: high-priority
```
