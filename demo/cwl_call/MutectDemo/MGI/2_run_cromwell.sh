# Run CWL Somatic SV Workflow using Cromwell at MGI
# Usage:
# bash run_cromwell.sh [options] 
#
# YAML is input file which defines all arguments to workflow
# Options:
#   -c config : set Cromwell config file.  Default: cromwell_config.ini
#
# Output will be in ./results directory

# Defaults
CONFIG="dat/cromwell-config-db.dat"
# http://wiki.bash-hackers.org/howto/getopts_tutorial
while getopts ":dc:" opt; do
  case $opt in
    d)  # example of binary argument
      >&2 echo "Dry run"
      DRYRUN=1
      ;;
    c) # example of value argument
      CONFIG=$OPTARG
      >&2 echo "Cromwell config file: $CONFIG"
      ;;
    \?)
      >&2 echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      >&2 echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

source /opt/lsf9/conf/lsf.conf

SSW_ROOT="/gscuser/mwyczalk/projects/CWL/somatic_sv_workflow"
YAML="$SSW_ROOT/demo/cwl_call/MutectDemo/MutectDemo.yaml"
CWL="$SSW_ROOT/cwl/SomaticSV.cwl"

# Cromwell 35 in image  registry.gsc.wustl.edu/apipe-builder/genome_perl_environment:5
CROMWELL="/opt/cromwell.jar"

# from https://confluence.ris.wustl.edu/pages/viewpage.action?spaceKey=CI&title=Cromwell#Cromwell-ConnectingtotheDatabase
# Connecting to the database section
# Note also database section in config fil
DB_ARGS="-Djavax.net.ssl.trustStorePassword=changeit -Djavax.net.ssl.trustStore=/gscmnt/gc2560/core/genome/cromwell/cromwell.truststore"
CMD="/usr/bin/java -Dconfig.file=$CONFIG $DB_ARGS -jar $CROMWELL run -t cwl -i $YAML $CWL"

if [ $DRYRUN ]; then
    >&2 echo Dryrun: $CMD
else
    >&2 echo Running: $CMD
    eval $CMD
fi

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
fi
