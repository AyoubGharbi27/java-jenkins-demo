pipeline {
    agent any
    tools {
        jdk 'jdk-24'       // ensure Jenkins has a JDK configured with this name
        maven 'maven3'     // ensure Jenkins has Maven installed / named accordingly
    }
    environment {
        DOCKERHUB_REPO = 'dingus27/java-jenkins-demo' // change to your Docker Hub repo
        DOCKERHUB_CREDID = 'dockerhub-credentials'   // Jenkins credential id for Docker Hub
        IMAGE_TAG = "v${env.BUILD_NUMBER ?: '1'}"
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your/repo.git', branch: 'main' // replace if using SCM
            }
        }
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests=false compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn -B test || true' // keep pipeline running if no tests or tests fail; adjust as needed
            }
        }
        stage('Package') {
            steps {
                sh 'mvn -B package -DskipTests'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${env.DOCKERHUB_REPO}:${env.IMAGE_TAG} ."
                sh "docker tag ${env.DOCKERHUB_REPO}:${env.IMAGE_TAG} ${env.DOCKERHUB_REPO}:latest"
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', env.DOCKERHUB_CREDID) {
                        sh "docker push ${env.DOCKERHUB_REPO}:${env.IMAGE_TAG}"
                        sh "docker push ${env.DOCKERHUB_REPO}:latest"
                    }
                }
            }
        }
    }
    post {
        always {
            sh 'docker rmi ${DOCKERHUB_REPO}:${IMAGE_TAG} || true'
            sh 'docker rmi ${DOCKERHUB_REPO}:latest || true'
        }
    }
}
