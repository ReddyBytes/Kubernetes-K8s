# Node Selector: (shows Pending status)
This is used to deploy our application on particular Node with our requirements. To implement this we need to add label same same as in both Node and pod   

![](https://bhavyasree.github.io/kubernetes-CKAD/Screens/node-selector.png)

here you can see the nodeSelector with size  means this pod only deployed on the node with same label for that  
  
    kubectl edit node <node-name>  

    find label section then add same line as  "size=Large"


# Node Affinity :  
Is of 2 types:  
1) __Preffered  :__ 1st search for 100% match with label node and schedules on that node, if it not find match schedule on any node.  
    
2) __Required :__ similar to Node Selector not find the match not schecduled .  

# Taints :
when we want to unschedule any pods on the node then we use taints. Means this node will not allow any pods to be scheduled on this.  
### why we need taints ??  
To  __upgrade nodes__  
how means we transfer all the pods on thet nonde to another node and bring downs the node and upgrade the node then again same process.  

### Types of taint effects 
1) __NoSchedule :__   
 Prevents new pods from being scheduled onto the node. Tt does not affect pods that are already running.  


        kubectl taint nodes <node-name> key1=value1:NoSchedule

2) __PreferNoSchedule :__   
   Best use for performance weak nodes  
   Kubernetes scheduler will attempt to avoid placing new pods on the node. If no other suitable nodes are available, the scheduler might still place the pod on the this tainted node.  
     
       kubectl taint nodes <node-name> key2=value2:PreferNoSchedule

3) __NoExecute :__  
   Preventing new pods from being scheduled, it also removes any existing running pods also. Better to avoid this taint.

       kubectl taint nodes <node-name> key3=value3:NoExecute
   

#### untaint the node  
  
    kubectl taint nodes <node-name> <key> --remove-override
    kubectl taint nodes <node-name>-   # - untaints the node


for more information [see here](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)  


# Toleration :  
Is  like an Exception. even though the node is tainted we can still schedule the pod on the node by adding toleration in yaml file  

see the [yaml]()