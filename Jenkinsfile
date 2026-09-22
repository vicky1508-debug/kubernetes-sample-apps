pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'YOUR_DOCKERHUB_USERNAME/game-2048'
    }
    
    stages {
        stage('Fetch Code') {
            steps {
                // Pull the code from your GitHub repository
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }
        
        stage('Push to Registry') {
            steps {
                // Securely log into Docker Hub using credentials stored in Jenkins
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Apply the Kubernetes manifests to your cluster
                sh 'kubectl apply -f k8s-deployment.yaml'
            }
        }
    }
}

