# Build the image using the above Dockerfile.
docker build -t wordpress ~/docker/wordpress/.

# To run the container
docker run –itd –name="wordpress" -p 80:80 wordpress
