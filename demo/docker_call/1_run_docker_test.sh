IMAGE="mwyczalkowski/somatic_sv_workflow:20200108"

# data will be with respect to container: this is test data contained within image
TUMOR="demo/demo_data/G15512.HCC1954.1.COST16011_region.bam"
NORMAL="demo/demo_data/HCC1954.NORMAL.30x.compare.COST16011_region.bam"
REF="demo/demo_data/Homo_sapiens_assembly19.COST16011_region.fa"

# The data generated here will generally be lost
docker run $IMAGE bash src/process_sample.sh -C --generateEvidenceBam $TUMOR  $NORMAL  $REF 
#docker run $IMAGE bash testing/direct_call/run_test_dataset.sh
