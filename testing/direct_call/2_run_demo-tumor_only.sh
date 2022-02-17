TUMOR="/data/G15512.HCC1954.1.COST16011_region.bam"
REF="/data/Homo_sapiens_assembly19.COST16011_region.fa"

OUTD="/results/tumor-only"
mkdir -p $OUTD

cd ../..
CMD="/bin/bash /usr/local/SomaticSV/src/process_SomaticSV.sh "$@" -t $TUMOR -r $REF -o $OUTD"
echo Running $CMD
eval $CMD


