# java-app
# Write pipeline-as-code to deploy containerised application. You can choose any sample application written in java, nodejs or php. 

# Solution

# Sample Java Application: java-app
    - This sample application contains 
        -SRC
            - main
                - webapp
                    - WEB-INF
                        - web.xml
                    - index.jsp
        pom.xml

    - index.jsp contains sample code which prints 'Hello World from java-app! (paas-task-2)'
    - pom.xml


# project(pipeline-as-code): paac-task-2
    -  Sample Java Code
    - 'Dockerfile' which is responsible for building and tagging the sample nodejs image
    - 'Jenkinsfile' which is responsible for building and tagging the sample nodejs image
        - 
        - Stage 1:
            - Build and Generate war file 
        - Stage 2:
            - ECR login
        - Stage 3:
            - Build Docker image
        - Stage 4:
            - Tagging image
        - Stage 5:
            - Push image to ECR
        - Stage 6:
            - Deploy the latest image in ECR cluster and activate service

## AWS Configuration

-   We have to creare IAM role  `ecsTaskExecutionRole` role and attch policy: `AmazonECSTaskExecutionRolePolicy` 
-   Create AWS ECR repository
-   Create AWS ECS cluster: `java-app`   of type `Fargate` in default region us-east-1
-   Create a task definition: `java-app` for the cluster
-   ![image](https://user-images.githubusercontent.com/18718672/133916407-47d2e4a6-eabc-4091-bea4-d1a51561b080.png)
-   ![image](https://user-images.githubusercontent.com/18718672/133916443-ed6a9233-e7e9-4e0f-86c1-7141f4e20162.png)
-   ![image](https://user-images.githubusercontent.com/18718672/133916474-f0142700-13e9-4c7b-9084-1ea596b169df.png)


##  Github Configuration

-  Create webhook for the repository: paac-task-2
-  Generate secret for Jenkins

## Jenkins Configuration
- Add AWS Keys to Jenkins
- Add GitHub repository secret to Jenkins server
- Pipeline
- ![image](https://user-images.githubusercontent.com/18718672/133916539-620e96a3-86c0-4759-9808-09513c101b05.png)



- If we make any changes to the code (app code, Jenkins file or Docker file), Jenkins pipeline will trigger and all the above mentioned stages will be executed and latest changes will be pushed to ECR, it will create a new task defination and it will be active and old task will be removed once the new task started running by create new task definition, update the ECS service and start a rolling deployment. 

- After the change deployed sucessfully, access the application with pulic ip
    http://publicip:8080/java-app/index.jsp
    
    ![image](https://user-images.githubusercontent.com/18718672/133916504-720f8bf3-2052-4669-b733-3f00ea4c1b9a.png)


