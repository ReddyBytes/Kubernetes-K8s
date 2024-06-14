## Kind Installation : 
__Step 1 :__ Go to the [website](https://kind.sigs.k8s.io/docs/user/quick-start/) use command as per ur machine here i am following installation on ubuntu machine  
  
    # For AMD64 / x86_64
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
    # For ARM64
    [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-arm64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind  

__Step 2 :__ create a cluster
  
    kind create cluster --name kind-2

__Step 3 :__ install the kubectl follow [this page](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)  
  
    curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl  

__Step 4 :__ find the best path to place kubectl and mv the kubectl to that path and change the permissions for kubectl  
  
    echo $PATH

    mv kubectl /usr/local/bin

    chmod +x /usr/local/bin/kubectl  

__Step 5 :__ copy the command that u can find after the kind create command  
  
    kubectl cluster-info --context kind-praccluster