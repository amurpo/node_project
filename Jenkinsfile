pipeline {
    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
        DOCKER_IMAGE_NAME = "amurpo/node_project"
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out the repository
                checkout scm
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                // Authenticate with Docker Hub using credentials
                withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    // Log in to Docker Hub
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"

                    // Build the Docker image and tag it with the version number
                    sh "docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG ."

                    // Push the Docker image to Docker Hub
                    sh "docker push $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
                }
            }
        }
    }
}
