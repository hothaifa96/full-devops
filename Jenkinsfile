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
        // stage("Test"){
        //     steps{
        //         // sh "docker run -p 5000:5000 -d --name h1 ${env.IMAGE_NAME} "
        //         // sh "pip3 install pytest"
        //         // sh "pytest ./test/test.py"
        //     }  
            
        // }
        stage("publishing the image"){
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId: "aws-cre"]]) {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 514080426196.dkr.ecr.us-east-1.amazonaws.com'
                    sh "docker tag ${env.IMAGE_NAME} 514080426196.dkr.ecr.us-east-1.amazonaws.com/demo1:latest"
                    sh "docker push 514080426196.dkr.ecr.us-east-1.amazonaws.com/demo1:latest"
                }
            }
            
        }

        stage('Terraform ') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId: "aws-cre"]]) {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 514080426196.dkr.ecr.us-east-1.amazonaws.com'
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
   
}
