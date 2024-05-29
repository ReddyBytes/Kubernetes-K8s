# ImagePullBackOffError:  
Generally this error occurs in 2 cases:  

## Case 1:  
__a) Invalid image :__ if the given image name is not present in the dockerhub then this error will araise.  

__b) Non Existant image :__ If the image is present in previous and we deployed a pod also but due to some reasons if the image is deleted then this error will occur.  

## Case 2:  
- If the image is __Private__ then we face this error .  
  if our organizationwants to deploy thos type of errors then we can use __imagePullSecure__ parameter in yml file which accepts credentials of dockerhub.  

How to identify that which is the reason for error ??  
1) kubectl descibe  
2) events



