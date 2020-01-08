# Basic script to start docker container

IMAGE="mwyczalkowski/somatic_sv_workflow:20200108"

# Starting with no mounted volumes:
docker run -it $IMAGE
