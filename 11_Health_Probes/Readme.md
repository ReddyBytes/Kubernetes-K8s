# Kubernetes Health Probes

### What Are Health Probes?

- Health probes in Kubernetes are used to `check the health of a container`.  
- These probes help **Kubelet (the Kubernetes agent)** know if a container is working properly and whether it should be restarted or removed from serving traffic.  
- Without health probes, Kubernetes would only detect if a container crashes but wouldn't know if it’s functioning properly or not.

### Why Are Health Probes Needed?

- **Improves reliability**: Detects if a container becomes unresponsive, even if it doesn't crash.
- **Prevents serving bad containers**: Ensures that only healthy containers receive traffic.
- **Automatic healing**: Restarts unhealthy containers, keeping the system stable.

## Types of Probes

### 1. Liveness Probe
- **Purpose**: `Checks if the container is still alive (working as expected).`
- **Action**: If the probe fails, Kubernetes **restarts the container**.
- **Use case**: Useful when your app can hang or become stuck. This probe ensures such containers are restarted.

#### Parameters:
- **exec**: Executes a command inside the container. If the command returns `0`, the container is considered healthy.
- **httpGet**: Makes an HTTP GET request to a specified path and port.
  - `path`: The endpoint to check (e.g., `/health`).
  - `port`: The port to check (e.g., `8080`).
  - `scheme`: The HTTP scheme (HTTP or HTTPS).
- **tcpSocket**: Checks if the specified TCP port is open.
  - `port`: The port number to check (e.g., `3306` for a database).
- **initialDelaySeconds**: How long to wait before starting checks.
- **periodSeconds**: Time between each probe.
- **timeoutSeconds**: How long to wait before marking the probe as failed.
- **failureThreshold**: How many failures before restarting the container.
- **successThreshold**: The number of consecutive successes for the probe to be considered successful after it has failed.

Example:
```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

### 2. Readiness Probe

#### **Purpose**:
- `Checks if the container is ready to serve traffic`.
- If a pod is running but not ready to handle requests (e.g., during initialization), the readiness probe will ensure that Kubernetes doesn't send traffic to it until it's ready.

  
#### **Action**:
- If the probe fails, Kubernetes will **temporarily remove the container from the service endpoints** (it won't receive traffic).
- Once the container is ready again, it will be added back to the list of endpoints that receive traffic.
- This probe is not able to restart the container.

#### **Use Case**:
- Use **Readiness Probes** when your app requires some time to load, connect to a database, or become operational after startup.
- Useful when an application goes into a temporary **unavailable state** but will recover soon, avoiding unnecessary restarts.

#### **Parameters**:
- **exec**: Runs a command inside the container. If the command returns `0`, the container is considered ready.
- **httpGet**: Sends an HTTP GET request to a specific path on a specified port.
  - `path`: The path to check (e.g., `/ready`).
  - `port`: The port to check (e.g., `8080`).
  - `scheme`: Protocol (HTTP or HTTPS).
- **tcpSocket**: Tests whether the specified TCP port is open and accepting traffic.
  - `port`: The port number to check (e.g., `80`).
- **initialDelaySeconds**: How long to wait after the container starts before performing the probe.
- **periodSeconds**: How often to perform the probe (in seconds).
- **timeoutSeconds**: How long to wait before marking the probe as failed.
- **successThreshold**: The number of consecutive successes for the probe to be considered successful after it has failed.
- **failureThreshold**: The number of consecutive failures needed before Kubernetes marks the container as "not ready".

#### **Example**:
```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
  timeoutSeconds: 2
  successThreshold: 1
  failureThreshold: 3

```

### 3. Startup Probe

- A **Startup Probe** in Kubernetes is used to check if a container has successfully started. 
- It is helpful when your container takes a long time to initialize, ensuring that Kubernetes does not prematurely restart the container or start health checks like liveness or readiness probes before the container is fully ready.

#### Why Are Startup Probes Needed?

- **Prevents premature restarts**: Some containers take a long time to start (e.g., applications that load large datasets or connect to external services). A Startup Probe allows Kubernetes to give the container enough time to start without mistakenly thinking it has failed.
- **Delays liveness and readiness probes**: While the Startup Probe is running, Kubernetes will pause both the **Liveness Probe** and **Readiness Probe** to prevent unnecessary restarts or health check failures.
- **Smooth container startup**: Ensures that the container is fully operational before any other health checks begin.

#### How Does the Startup Probe Work?

- **Kubelet** uses the startup probe to check if the application inside the container has successfully started.
- If the **Startup Probe** fails, the container will be restarted.
- Once the **Startup Probe** succeeds, the other probes (Liveness and Readiness) will start checking the health and readiness of the container.

#### **Parameters** 

- **exec**: Executes a command inside the container. If the command returns `0`, the container is considered started.
- **httpGet**: Sends an HTTP GET request to a specified path and port.
  - `path`: The HTTP path to check (e.g., `/startup`).
  - `port`: The port to check (e.g., `8080`).
  - `scheme`: HTTP or HTTPS.
- **tcpSocket**: Checks if a TCP port is open and listening.
  - `port`: The TCP port to check (e.g., `3306`).
- **initialDelaySeconds**: How long to wait before performing the first probe after the container starts (in seconds).
- **periodSeconds**: How often (in seconds) to perform the probe.
- **timeoutSeconds**: Maximum time allowed for a probe to complete (in seconds).
- **failureThreshold**: How many consecutive failures Kubernetes will tolerate before restarting the container.

Example :

```yaml
startupProbe:
  httpGet:
    path: /startup
    port: 8080
  initialDelaySeconds: 20
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3

```


#### **Referance Doumentation** 
[Kubernetes Dcumentation Here](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
