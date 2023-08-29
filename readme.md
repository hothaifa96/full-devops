In this exercise, you’ll create a Jenkins pipeline that implements a basic CI strategy in which you build and deploy flask app

The pipeline should include two types of flows, implemented as two separate stages or more in a single
Jenkinsfile.
Each stage should run only if its condition is met.
The Jenkinsfile agent should be the “controller” itself.

Exercise overview
1. Build build the docker image after writing dockerfile 
2. Deploy: upload Docker image to ECR.
3. Pull & Test: Pull Docker image from ECR. Run a container
4. triger terraform to build ec2 with the contaner runing inside it
The stage should run on a periodic basis (for example, every-day at 17:00).



# Exercise details
# 1) Setup (non-chronological order):
# a) Create a GIT repository in github which will host your:
# i) Python script
# ii) Dockerfile
# iii) Jenkinsfile
# iv) requirements.txt
# V) terraform folder or file

# c) Write a Dockerfile that holds the required environment for the execution of your
# Python script.
# e) Create an ECR repository (Region: us-east-1, Name: <YOUR_NAME>).
# f) Run a new EC2 in AWS (Region: us-east-1, Name: <YOUR_NAME>)
# g) On that EC2, run a new Jenkins instance:
# i) The instance should run inside a Docker container.
# ii) Use the next Jenkins Docker image:
# iii) There are 2 necessary volumes you should map from the host to the
# Jenkins container:
# (1) /var/jenkins_home - to retain the Jenkins data
# (2) /var/run/docker.sock - to enable "Docker outside of Docker"
# h) Compose the Jenkinsfile and create a matching Jenkins pipeline job which runs
# it.


# after the ci job 
# run single stage called release 
# thats runs a pre configured terraform file to start the code