#/bin/bash
# Run Manta SV caller and filter
# Usage: process_sample.sh [options] tumor.bam normal.bam reference.fa 
# 
# Options [ defaults ]:
# -v : verbose output
# -o out_dir : Output directory [ ./output ]
# -c cpu : CPU count [ 4 ]
# -f output.vcf : specify output filename in manta results dir [ final.SV.WGS.vcf ]
# -T : use test args, specific to "COST16011" data in testing/demo_data

# Set defaults
OUTD="./output"
OUTVCF="final.SV.WGS.vcf"
CPU="4"

# Load the conda environment
# It would be better to do this in Docker image...
if [ -z "$CONDA_DEFAULT_ENV" ]; then
    source /opt/conda/bin/activate base
fi


# http://wiki.bash-hackers.org/howto/getopts_tutorial
while getopts ":vo:c:f:T" opt; do
  case $opt in
    v)  # binary argument
      VERBOSE=1
      >&2 echo "Verbose output"
      ;;
    o) # value argument
      OUTD=$OPTARG
      >&2 echo "Output directory: $OUTD "
      ;;
    c) # value argument
      CPU=$OPTARG
      >&2 echo "CPU: $CPU "
      ;;
    f) # value argument
      OUTVCF=$OPTARG
      >&2 echo "Output VCF filename: $OUTVCF "
      ;;
    T)  # binary argument
        # These args are just for testing.  Obtained from failed run of 
        #	python /opt/conda/share/manta-1.4.0-1/bin/runMantaWorkflowDemo.py
	# Test run succeeds without these args, but takes longer to run
      TESTARGS=" --region=8:107652000-107655000 --region=11:94974000-94989000 --candidateBins=4 --exome "
      >&2 echo "TESTARGS set for COST16011 test dataset"
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


if [ "$#" -ne 3 ]; then
    >&2 echo Error: Wrong number of arguments
    exit 1
fi

TUMOR=$1
NORMAL=$2
REF=$3

# uncompress REF if necessary.  This would typically be used just for test data
if [[ ! -e $REF && -e "$REF.tar.bz2" ]]; then
    echo Uncompressing "$REF.tar.bz2"
    D=$(dirname $REF)
    tar -xvjf "$REF.tar.bz2" -C $D
fi


if [ ! -e $TUMOR ]; then
    >&2 echo Error: tumor does not exist: $TUMOR
    exit 1
fi
if [ ! -e $NORMAL ]; then
    >&2 echo Error: normal does not exist: $NORMAL
    exit 1
fi
if [ ! -e $REF ]; then
    >&2 echo Error: reference does not exist: $REF
    exit 1
fi

# First configure manta
configManta.py --tumorBam $TUMOR --normalBam $NORMAL --referenceFasta $REF --runDir $OUTD $TESTARGS
rc=$? # catch errors
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
else
    >&2 echo configManta.py success.
fi


# now run manta
$OUTD/runWorkflow.py -m local -j $CPU
rc=$? # catch errors
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
else
    >&2 echo runWorkflow.py success.
fi

# VCF below is generated by manta
VCF="$OUTD/results/variants/somaticSV.vcf.gz"
# We place output file in the same directory as manta output
OVCF="$OUTD/results/variants/$OUTVCF"

python /usr/local/somatic_sv_workflow/filter_vcf.py $VCF $OVCF


rc=$? # catch errors
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
else
    >&2 echo filter_vcf.py success.
fi

>&2 echo Written to $OVCF
>&2 echo process_sample.sh success.
