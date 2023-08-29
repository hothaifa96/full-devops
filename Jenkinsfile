pipeline{
    agent any 
    environment{
        IMAGE_NAME="${env.Git_BRANCH.toLowerCase()}:v${env.BUILD_ID}"
        PORT = 5000
        
    }
    stages{
        stage("build image"){
            steps{
                sh "docker build -t ${env.IMAGE_NAME} ./server"
            }  
            
        }
        stage("Test"){
            steps{
                sh "docker run -p 5000:5000 -d --name h1 ${env.IMAGE_NAME} "
                sh "pytest -m ./test/test.py"
            }  
            
        }
        stage("publishing the image"){
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId: "aws-cre"]]) {
                    sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/e9i1b6d1'
                    sh "docker tag ${env.IMAGE_NAME} public.ecr.aws/e9i1b6d1/demo1:latest"
                    sh "docker push public.ecr.aws/e9i1b6d1/demo1:latest"
                }
            }
            
        }
    }
   
}