pipeline {
    agent any

    stages {
        stage('Build java app') {
            steps {
                sh 'mvn install && ls && pwd'
            }
        }
        stage('ECR login ') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 779468985484.dkr.ecr.us-east-1.amazonaws.com'
            }  
            }
        stage('Build DOcker image') {
            steps {
                sh 'docker build -t 779468985484.dkr.ecr.us-east-1.amazonaws.com/javarepo:latest .'
            }   
        }
        stage('tagging image') {
            steps {
                sh 'docker tag 779468985484.dkr.ecr.us-east-1.amazonaws.com/javarepo:latest 779468985484.dkr.ecr.us-east-1.amazonaws.com/javarepo:$BUILD_NUMBER'
            }  
            }
        stage('Push image to ECR') {
            steps {
                sh 'docker push 779468985484.dkr.ecr.us-east-1.amazonaws.com/javarepo:latest && docker push 779468985484.dkr.ecr.us-east-1.amazonaws.com/javarepo:$BUILD_NUMBER'
            }  
            }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {                
                sh '''
                    TASK_FAMILY="java-app"
                    SERVICE_NAME="java-app-service"
                    NEW_DOCKER_IMAGE="779468985484.dkr.ecr.us-east-1.amazonaws.com/javarepo:$BUILD_NUMBER"
                    CLUSTER_NAME="java-app"
                    OLD_TASK_DEF=$(aws ecs describe-task-definition --region us-east-1 --task-definition $TASK_FAMILY --output json)
                    NEW_TASK_DEF=$(echo $OLD_TASK_DEF | jq --arg NDI $NEW_DOCKER_IMAGE '.taskDefinition.containerDefinitions[0].image=$NDI')
                    FINAL_TASK=$(echo $NEW_TASK_DEF | jq '.taskDefinition|{family: .family, volumes: .volumes, memory: .memory, containerDefinitions: .containerDefinitions}')
                    echo $FINAL_TASK
                    aws ecs register-task-definition --family $TASK_FAMILY --requires-compatibilities "FARGATE" --region us-east-1 --execution-role-arn "arn:aws:iam::779468985484:role/ecsTaskExecutionRole" --cpu "256" --memory "512" --network-mode "awsvpc" --cli-input-json "$(echo $FINAL_TASK)"
                    aws ecs update-service --service $SERVICE_NAME --region us-east-1 --task-definition $TASK_FAMILY --cluster $CLUSTER_NAME
                '''
            }
        }
    }
}
