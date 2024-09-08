pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'abhibindel/test:latest'
        DOCKER_REPO = 'abhibindel/test'
        SSH_CREDENTIALS_ID = 'docker_ssh' // Jenkins SSH credentials ID
        DOCKER_SERVER_IP = '3.111.38.104' // Docker server IP
        SSH_PORT = 22 // Default SSH port, update if different
    }

    stages {
        stage('Connect to Docker Server and Build Docker Image') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        // Build Docker image on the Docker server
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} '
                            cd /root/devops-assignment &&
                            docker build -t ${DOCKER_IMAGE} .
                        '
                        """
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        // Push Docker image to Docker Hub
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} '
                            docker push ${DOCKER_IMAGE}
                        '
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up or notifications
            echo 'Pipeline completed'
        }
    }
}

