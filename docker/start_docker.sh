# Basic script to start docker container

IMAGE="mwyczalkowski/somatic_sv_workflow:20200102"

# Starting with no mounted volumes:
docker run -it $IMAGE

# Starting run with mounted volume:
#DATAD="/Users/mwyczalk/Projects/Rabix/TinDaisy/StrelkaDemo.dat"
#docker run -v $DATAD:/data -it $IMAGE

# TIPS:

# To start another terminal in running container, first get name of running container with `docker ps`,
# then start bash in it with,
# `docker exec -it <container_name> bash`

