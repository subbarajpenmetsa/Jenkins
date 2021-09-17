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
                sh './update-service.bash'
            }
        }
    }
}
