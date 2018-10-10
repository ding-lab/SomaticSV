cd ..

TUMOR="testing/demo_data/G15512.HCC1954.1.COST16011_region.bam"
NORMAL="testing/demo_data/HCC1954.NORMAL.30x.compare.COST16011_region.bam"
REF="testing/demo_data/Homo_sapiens_assembly19.COST16011_region.fa"
OUTD="/usr/local/somatic_sv_workflow/testing/output.tmp"

# uncompress REF if necessary 
if [[ ! -e $REF && -e "$REF.tar.bz2" ]]; then
    echo Uncompressing "$REF.tar.bz2"
    D=$(dirname $REF)
    tar -xvjf "$REF.tar.bz2" -C $D
fi

# NOTE: it is required to uncompress reference with,
# 	tar -xvfj Homo_sapiens_assembly19.COST16011_region.fa.tar.bz2
# before running demo


bash process_sample.sh -o $OUTD $TUMOR $NORMAL $REF
