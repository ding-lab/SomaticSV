# Testing of cromwell at MGI

# DEMO
1. `init_MGI.sh`
2. mkdir -p config
2. `bash make_config.sh ./results > config/cromwell_config.dat`
3. `bash run_cromwell.sh ../Demo.yaml`

# C3L-00001 run
Note that C3L-00001 BAMs are stored on gc2619
As above, but with
2. `bash make_config.sh /gscmnt/gc2619/dinglab_cptac3/cromwell-workdir > config/cromwell_config.dat`
3. `bash run_cromwell.sh -c config/cromwell_config.dat ../C3L-00001.MGI.yaml"

-> Results are saved in 
/gscmnt/gc2619/dinglab_cptac3/cromwell-workdir/cromwell-executions/somatic_sv_workflow.cwl/acd30997-d936-43da-9053-82e836c26953/call-somatic_sv_workflow.cwl/execution/output/results/variants/final.SV.WGS.vcf

** TODO

Streamline, document this process
How can we reliably obtain final vcf after process completes?
