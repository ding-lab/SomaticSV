IMAGE="mwyczalkowski/somatic_sv_workflow"

# data will be with respect to container: this is test data contained within image
TUMOR="testing/demo_data/G15512.HCC1954.1.COST16011_region.bam"
NORMAL="testing/demo_data/HCC1954.NORMAL.30x.compare.COST16011_region.bam"
REF="testing/demo_data/Homo_sapiens_assembly19.COST16011_region.fa"

# -T makes demo data analysis go faster
# The data generated here will generally be lost
docker run $IMAGE bash process_sample.sh -T $TUMOR  $NORMAL  $REF 
#docker run $IMAGE bash testing/direct_call/run_test_dataset.sh
