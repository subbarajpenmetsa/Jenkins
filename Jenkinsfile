pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn install && ls && pwd'
                sh 'docker build -t hello-world:v1 .'
            }
            
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
