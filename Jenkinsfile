pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'YOUR_DOCKER_USERNAME/custom-nginx' 
        IMAGE_TAG = "v${env.BUILD_NUMBER}" 
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} .'
            }
        }
        
        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push ${DOCKER_IMAGE}:${IMAGE_TAG}'
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'k8s-config']) {
                    sh 'kubectl apply -f app-deployment.yaml'
                    sh 'kubectl set image deployment/custom-nginx custom-nginx=${DOCKER_IMAGE}:${IMAGE_TAG}'
                }
            }
        }
    }
}
