pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'abhibindel/test'
        DOCKER_IMAGE_TAG = 'latest'
        DOCKERFILE_PATH = '/root/devops-assignment/Dockerfile'
        SSH_CREDENTIALS_ID = 'docker_ssh'
        DOCKER_SERVER_IP = '13.232.226.188'
        SSH_PORT = 22
        DEPLOYMENT_NAME = 'nft-bridge-app'
        KUBE_CONFIG_PATH = '/root/k8s-devops-assignment-kubeconfig.yaml'
    }

    stages {
        stage('SSH Setup') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} "echo 'SSH setup complete'"
                        """
                    }
                }
            }
        }

        stage('Install Dependencies and Run Tests') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} "cd /root/devops-assignment && docker pull node:14 && docker run --rm -v /root/devops-assignment:/app -w /app node:14 npm install"
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} "cd /root/devops-assignment && docker run --rm -v /root/devops-assignment:/app -w /app node:14 npm test"
                        """
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} "cd /root/devops-assignment && docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} -f ${DOCKERFILE_PATH} ."
                        """
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                        """
                    }
                }
            }
        }

        stage('Restart Kubernetes Deployment') {
            steps {
                script {
                    sshagent([SSH_CREDENTIALS_ID]) {
                        sh """
                        ssh -p ${SSH_PORT} root@${DOCKER_SERVER_IP} "kubectl --kubeconfig=${KUBE_CONFIG_PATH} rollout restart deployment/${DEPLOYMENT_NAME}"
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
        }
    }
}
