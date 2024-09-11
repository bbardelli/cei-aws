#!/bin/bash
sudo yum update -y
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo yum install git -y
sudo pip3 install cherrypy
sudo pip3 install boto3
sudo pip3 install redis
git clone https://github.com/bbardelli/cei-aws.git
export DYNAMO_AWS_REGION=eu-south-2
export DYNAMO_TABLE=my_exam_table
sudo python3 cei-aws/exam-server/app.py