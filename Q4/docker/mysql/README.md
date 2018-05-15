# Build the image using the above Dockerfile.

docker build -t mysql ~/docker/mysql/.


# To run the container

docker run -d --name="mysql" -e "MYSQL_PASSWORD=password" mysql
