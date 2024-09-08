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
        stage('Setup SSH Connection and Execute Commands') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} << 'EOF'
                            # Change to the directory containing the Dockerfile
                            cd /root/devops-assignment
                            
                            # Build Docker image
                            docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} -f ${DOCKERFILE_PATH} .
                            
                            # Push Docker image to Docker Hub
                            docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
                            
                            # Restart Kubernetes deployment
                            kubectl --kubeconfig=${KUBE_CONFIG_PATH} rollout restart deployment/${DEPLOYMENT_NAME}
                        EOF
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
