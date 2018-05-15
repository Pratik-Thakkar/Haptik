Q1 a.) Bash script to setup a whole LAMP stack, PHP app can be Wordpress and DB can be MySQL.
This script should install all components needed for a Wordpress website.
We should be able to run this script on a local machine or server and after execution of the
script it should have Wordpress Running via Nginx/Apache.
DB user for Wordpress should also be made automatically from within the script and same
should be set in Wordpress conf file.


Q2. Architecture Diagram for a PHP/JAVA/Python based application to be hosted on AWS with all mentions like VPC, AWS/any other cloud platform services, well defined network segregation.


Q3. Write a script which will based on “Number of requests” metric of the ALB/ELB scale up webapp EC2 instances under the Load Balancer, increase AWS Elasticsearch Nodes count,and change the instance size of a MongoDB EC2 instance from m4.large to m4.xlarge. (without using ASG)


Q4. Docker Related:
Part 1. Write a Docker file to create a Docker image which should have wordpress installed
Part 2. Write a Docker file to create a Docker image for database

Now, use Docker compose to bring up the above Docker images as containers. Database container should mount the local host's “/etc/mysql” volume into it's (containers) /etc/mysql directory.
