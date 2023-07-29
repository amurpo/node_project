pipeline {
    agent {
        label 'docker-agent'
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out the repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image and tag it with a version number
                script {
                    docker.build("amurpo/node_project:${env.BUILD_NUMBER}")
                }
            }
        }
    }
}
