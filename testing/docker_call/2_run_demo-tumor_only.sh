cd ../..
source docker/docker_image.sh

TUMOR="/data/G15512.HCC1954.1.COST16011_region.bam"
REF="/data/Homo_sapiens_assembly19.COST16011_region.fa"

ARGS="-C --generateEvidenceBam"

# This is what we want to run in docker
OUTD="/results/tumor-only-docker"
CMD_INNER="/bin/bash /usr/local/SomaticSV/src/process_SomaticSV.sh "$@" -t $TUMOR -r $REF -o $OUTD"

SYSTEM=docker   # docker MGI or compute1
START_DOCKERD="docker/WUDocker"  # https://github.com/ding-lab/WUDocker.git

DATAD="testing/demo_data"
OUTD_H="../output"
VOLUME_MAPPING="$DATAD:/data $OUTD_H:/results"

>&2 echo Launching $IMAGE on $SYSTEM
CMD_OUTER="bash $START_DOCKERD/start_docker.sh -l -I $IMAGE -M $SYSTEM -c \"$CMD_INNER\" $VOLUME_MAPPING "
echo Running: $CMD_OUTER
eval $CMD_OUTER

