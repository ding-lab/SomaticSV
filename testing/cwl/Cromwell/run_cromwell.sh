# Run CWL Somatic SV Workflow using Cromwell at MGI
# Usage:
# bash run_cromwell.sh [options] YAML
#
# YAML is input file which defines all arguments to workflow
# Options:
#   -c config : set Cromwell config file.  Default: cromwell_config.ini
#
# Output will be in ./results directory

# Defaults
CONFIG="cromwell_config.dat"
# http://wiki.bash-hackers.org/howto/getopts_tutorial
while getopts ":dc:" opt; do
  case $opt in
    d)  # example of binary argument
      >&2 echo "Dry run"
      DRYRUN=1
      ;;
    f) # example of value argument
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

if [ "$#" -ne 1 ]; then
    >&2 echo Error: Wrong number of arguments
    exit 1
fi

source /opt/lsf9/conf/lsf.conf
YAML=$1
CWL="../../../cwl/somatic_sv_workflow.cwl"

# Cromwell 35 in image  registry.gsc.wustl.edu/apipe-builder/genome_perl_environment:5
CROMWELL="/opt/cromwell.jar"

# https://stackoverflow.com/questions/2005192/how-to-execute-a-bash-command-stored-as-a-string-with-quotes-and-asterisk
CMD="/usr/bin/java -Dconfig.file=$CONFIG -jar $CROMWELL run -t cwl -i $YAML $CWL"

if [ $DRYRUN ]; then
    echo $CMD
else
    eval $CMD
fi


