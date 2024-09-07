pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git url: 'https://github.com/ashlesh-settlemint/devops-assignment.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                // Add your build steps here, e.g., build commands
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // Add your test steps here, e.g., run tests
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deploy steps here, e.g., deployment commands
            }
        }
    }
    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
