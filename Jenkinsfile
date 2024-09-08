pipeline {
    agent any

    environment {
        // Docker configuration
        DOCKER_IMAGE_NAME = 'abhibindel/test'
        DOCKER_IMAGE_TAG = 'latest'
        DOCKERFILE_PATH = '/root/devops-assignment/dockerfile'
        SSH_CREDENTIALS_ID = 'docker_ssh'
        DOCKER_SERVER_IP = '3.111.38.104'
        SSH_PORT = 22

        // Kubernetes configuration
        DEPLOYMENT_NAME = 'nft-bridge-app'
        KUBE_CONFIG_PATH = '/root/k8s-devops-assignment-kubeconfig.yaml'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        // SSH into Docker server and build Docker image
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} '
                            docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} -f ${DOCKERFILE_PATH} .
                        '
                        """
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        // SSH into Docker server and push Docker image to Docker Hub
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} '
                            docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
                        '
                        """
                    }
                }
            }
        }

        stage('Restart Kubernetes Deployment') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        // SSH into Docker server and restart the Kubernetes deployment
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} '
                            kubectl --kubeconfig=${KUBE_CONFIG_PATH} rollout restart deployment/${DEPLOYMENT_NAME}
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


