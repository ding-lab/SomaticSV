source docker_image.sh

cd ..
docker build -t $IMAGE -f docker/Dockerfile .
