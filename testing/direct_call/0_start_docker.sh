# Launch docker environment for testing SomaticSV

# changing directories so entire project directory is mapped by default
cd ../..
source docker/docker_image.sh
SYSTEM="docker" # appropriate for katmai

# maps to /data
DATAD="testing/demo_data"

# Maps to /results.  Make sure this directory exists
OUTD="../output"

>&2 echo Launching $IMAGE on $SYSTEM
CMD="bash docker/WUDocker/start_docker.sh $@ -I $IMAGE -M $SYSTEM $DATAD:/data $OUTD:/results"
echo Running: $CMD
eval $CMD




