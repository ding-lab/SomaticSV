TUMOR="../demo_data/G15512.HCC1954.1.COST16011_region.bam"
NORMAL="../HCC1954.NORMAL.30x.compare.COST16011_region.bam"
REF="../demo_data/Homo_sapiens_assembly19.COST16011_region.fa"
OUTD="output"

# NOTE: it is required to uncompress reference with,
# 	tar -xvfj Homo_sapiens_assembly19.COST16011_region.fa.tar.bz2
# before running demo
# uncompress REF if necessary 
if [[ ! -e $REF && -e "$REF.tar.bz2" ]]; then
    echo Uncompressing "$REF.tar.bz2"
    D=$(dirname $REF)
    tar -xvjf "$REF.tar.bz2" -C $D
fi

/bin/bash /usr/local/SomaticSV/src/process_sample.sh "$@" -o $OUTD $TUMOR $NORMAL $REF

