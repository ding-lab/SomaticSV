IMAGE="mwyczalkowski/cromwell-runner"

VOLUME_MAP="/storage1/fs1/m.wyczalkowski /home/m.wyczalkowski/Projects "

export LSF_DOCKER_NETWORK=host && ../../docker/WUDocker/start_docker.sh -I $IMAGE -M compute1 $VOLUME_MAP
