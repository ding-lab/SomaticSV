source docker_image.sh

>&2 echo Building $IMAGE

cd ..
docker build -t $IMAGE -f docker/$DOCKERFILE .
