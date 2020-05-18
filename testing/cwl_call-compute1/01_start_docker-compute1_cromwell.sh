IMAGE="mwyczalkowski/cromwell-runner"

echo Reminder: please invoke the following prior to starting docker
echo "     export LSF_DOCKER_NETWORK=host"


# Possibly need to mount these, from 
#    /storage1/fs1/home1/Active/home/m.wyczalkowski/Projects/GermlineCaller/GATK_GermlineCaller/testing/cwl_call/cromwell-compute1/01_start_docker.compute1.sh
# export LSF_DOCKER_VOLUMES="/storage1/fs1/m.wyczalkowski:/storage1/fs1/m.wyczalkowski /scratch1/fs1/lding:/scratch1/fs1/lding"

../../docker/WUDocker/start_docker.sh -I $IMAGE -M compute1
