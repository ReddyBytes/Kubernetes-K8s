# Demonsets
- A DaemonSet ensures that a specific pod runs on all or selected nodes within a Kubernetes cluster.   
- If new nodes are added to the cluster, the DaemonSet automatically adds the pod to those nodes as well. Conversely, when nodes are removed, the pods are also garbage collected.  

    ### Common Use Cases

    `Log Collection Agents:` Tools like Fluentd or Logstash can be deployed as DaemonSets to collect and ship logs from all nodes.  

    `Monitoring Agents:` Services like Prometheus Node Exporter or Datadog agents collect metrics from each node.  

    `Network Plugins:` Tools that manage networking aspects, such as Calico or Weave Net.  

    `Security Agents:` Applications that monitor security across all nodes.  


By using NodeSelector we can deploy Demonsets in specific nodes.as stated below   
  
    metadata:
    spec:
        template:
            spec:
                nodeSelector:
                    diskType: ssd



#  StatefulSets


A **StatefulSet** is a way to manage applications that need to remember their state (data or settings) across restarts or when scaling up or down.

### Key Features

#### 1. Stable, Unique Network Identifiers
- Pods managed by a StatefulSet are assigned unique, stable network identities.
- The network identity consists of an ordinal index (0, 1, 2, ...) appended to the StatefulSet name, ensuring each pod has a unique name like `web-0`, `web-1`, etc.
- These identities are preserved across rescheduling.

#### 2. Stable, Persistent Storage
- Each pod in a StatefulSet can have its own persistent storage, managed by PersistentVolumeClaims (PVCs).
- Persistent storage ensures that even if a pod is rescheduled or restarted, it continues to use the same storage volume.

#### 3. Ordered, Graceful Deployment and Scaling
- Pods in a StatefulSet are created, updated, and deleted in a specific order.
- When scaling up, the StatefulSet ensures that each pod is fully ready before creating the next one.
- When scaling down, pods are terminated in reverse order.

#### 4. Ordered Rolling Updates
- StatefulSets support ordered rolling updates, meaning updates are applied to pods in a specific sequence.
- Useful for applications that require careful management during updates.

### Common Use Cases

- **Databases**: MySQL, PostgreSQL, Cassandra, etc.
- **Distributed Systems**: Kafka, Zookeeper, etc.
- **Applications with Stable Network Identities**: Redis, MongoDB, etc.

m demon set