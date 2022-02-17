TUMOR="/data/G15512.HCC1954.1.COST16011_region.bam"
NORMAL="/data/HCC1954.NORMAL.30x.compare.COST16011_region.bam"
REF="/data/Homo_sapiens_assembly19.COST16011_region.fa"

OUTD="/results/tumor-normal"
mkdir -p $OUTD

CMD="/bin/bash /usr/local/SomaticSV/src/process_SomaticSV.sh "$@" -t $TUMOR -n $NORMAL -r $REF"
echo Running $CMD
eval $CMD


