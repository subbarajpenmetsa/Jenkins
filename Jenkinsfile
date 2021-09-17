pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                mvn install && ls && pwd
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
