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
## YAML syntax

### Strings, Numbers and Booleans :
  
    string: Hello, World!
    number: 42
    boolean: true
    
### Lists  
  
    fruits:
        - Apple
        - Banana
        - Cherry

### Dictionaries
  
    person:
        name: John Doe
        age: 30
        city: New York

### List of dictionaries 
  
    people:
        - name: John Doe
          age: 30
          city: New York
        - name: Jane Smith
          age: 28
          city: Chicago
        - name: Alice Johnson
          age: 35
          city: Los Angeles





## YAML in Kubernetes  

1) __apiVersion :__ This is the apiversion that we are using to create k8s objects.
   
       
         Pod: v1
         Service: v1
         ReplicaSet: apps/v1
         Deployment: apps/v1 
    
2) __kind :__  type of object
3) __metadata :__ the metadata about the object
      
4) __spec :__  additional details about the object 
   
   
![](https://media.licdn.com/dms/image/D5612AQEksLmcGmFENg/article-inline_image-shrink_1500_2232/0/1688282078065?e=1722470400&v=beta&t=0BMnZhP0CZGwkg6llnbpY751Fc90S1lGNa-afcfBy5w)
