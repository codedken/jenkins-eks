pipeline {
    agent any
    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        region = "us-east-1"
    }

    stages{
        stage("Checkout SCM"){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/codedken/jenkins-eks.git']])
                }
            }
        }

        stage("Initializing terraform"){
            steps{
                script{
                    dir('eks'){
                        sh 'terraform init'
                    }
                }
            }
        }

        stage("View the planned changes for the resources to be effected"){
            steps{
                script{
                    dir('eks'){
                        sh 'terraform plan'
                    }
                }
            }
        }
    }
}