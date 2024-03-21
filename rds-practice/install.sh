sudo apt-get update
sudo apt-get install python3-pip -y
sudo apt-get install mysql-client -y
git clone https://github.com/bbardelli/cei-aws.git
export RDS_HOST=mydbinstance.cjxjxjxjxjxj.eu-west-1.rds.amazonaws.com
mysql -h $RDS_HOST -u admin -p < cei-aws/rds-practice/script.sql
mysql -h $RDS_HOST -u admin -D dummy -p < cei-aws/rds-practice/dummy-data/dummy.sql