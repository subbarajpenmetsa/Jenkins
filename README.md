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

##  Github Configuration

-  Create webhook for the repository: paac-task-2
-  Generate secret for Jenkins

## Jenkins Configuration
- Add AWS Keys to Jenkins
- Add GitHub repository secret to Jenkins server


- If we make any changes to the code (app code, Jenkins file or Docker file), Jenkins pipeline will trigger and all the above mentioned stages will be executed and latest changes will be pushed to ECR, it will create a new task defination and it will be active and old task will be removed once the new task started running by create new task definition, update the ECS service and start a rolling deployment. 

- After the change deployed sucessfully, access the application with pulic ip
    http://publicip:8080/java-app/index.jsp
