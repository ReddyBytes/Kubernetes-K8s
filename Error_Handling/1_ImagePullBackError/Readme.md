# ImagePullBackOffError:  
Generally this error occurs in 2 cases:  

## Case 1:  
__a) Invalid image :__ if the given image name is not present in the dockerhub then this error will araise.  

__b) Non Existant image :__ If the image is present and deployed  in a pod, but due to some reasons if the image is deleted then also we will get this error.  

## Case 2:  
- If the image is __Private__ then we face this error .  
  if our organization wants to deploy this type of images then we need to use __imagePullSecure__ parameter in yml file which holds secrets ( credentials of dockerhub ).  

how to create secrets  
  
    kubectl create secret docker-registry myregistrykey \
    --docker-server=<your-registry-server> \
    --docker-username=<your-name> \
    --docker-password=<your-pword> \
    --docker-email=<your-email>

see the yaml file [here](/Error_Handling/1_ImagePullBackError/imagepullsecure.yml)  


How to identify that which is the reason for error ??  
1) kubectl descibe  
2) events



