# Be sure this is running within cromwell-compatible docker on compute1 with,
# 0_start_docker-compute1_cromwell.sh

source /opt/ibm/lsfsuite/lsf/conf/lsf.conf

#CWL="../../../cwl/SomaticSV.cwl"
CWL="../../../cwl/somaticsv-1-5.cwl"

CONFIG="config/cromwell-config-db.compute1-filedb.dat"
YAML="config/SomaticSV2_TumorNormal.Demo.yaml"  # Same YAML file

JAVA="/opt/java/openjdk/bin/java"
CROMWELL="/app/cromwell-78-38cd360.jar"

if [ ! -e $CONFIG ]; then
	>&2 echo ERROR: configuration file $CONFIG does not exist
	>&2 echo Please create it from template
	exit 1
fi

CMD="$JAVA -Dconfig.file=$CONFIG -jar $CROMWELL run -t cwl -i $YAML $CWL"

echo Running: $CMD
eval $CMD

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
fi

