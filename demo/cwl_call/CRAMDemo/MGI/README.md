# Testing of cromwell at MGI

Testing run of real (CRAM) data, as obtained from UMich group and downloaded to storage1.
Data copied to /gscmnt/gc2521/dinglab/mwyczalk/CPTAC3.share/cords-align
Reference: 

Will focus on HNSCC case C3N-00295, which has WGS data from CPT0008520010 (C3N-00295.WGS.T) and CPT0008550002 (C3N-00295.WGS.N)

Tumor BAM: /gscmnt/gc2521/dinglab/mwyczalk/CPTAC3.share/cords-align/CPT0008520010/CPT0008520010.cram
Normal BAM: /gscmnt/gc2521/dinglab/mwyczalk/CPTAC3.share/cords-align/CPT0008550002/CPT0008550002.cram
Reference: /gscmnt/gc2521/dinglab/mwyczalk/CPTAC3.share/GRCh38_full_analysis_set_plus_decoy_hla/GRCh38_full_analysis_set_plus_decoy_hla.fa

# C3N-00295 CRAM
1. `bash 0_start_docker-MGI_cromwell.sh`
2. `bash 1_make_config.sh`
3. edit `2_run_cromwell.sh`, modify `SSW_ROOT` parameter to point to base directory of `somatic_sv_workflow` project
4. `bash 2_run_cromwell.sh`

# Debugging during runs

## Failure 1
```
[2020-01-02T23:15:55.283551Z] [blade18-2-4.gsc.wustl.edu] [27_1] [TaskManager] [ERROR] [2020-01-02T23:15:55.200766Z] [blade18-2-4.gsc.wustl.edu] [27_1] [getAlignmentStats_generat
eStats_000] FATAL_ERROR: BAM/CRAM index is not available for file: '/cromwell-executions/SomaticSV.cwl/e9aaa9c2-6afc-4f4e-bf7e-cd706c0c7c50/call-SomaticSV.cwl/inputs/1466789091/C
PT0008550002.cram'
[2020-01-02T23:15:55.283551Z] [blade18-2-4.gsc.wustl.edu] [27_1] [TaskManager] [ERROR] [2020-01-02T23:15:55.203893Z] [blade18-2-4.gsc.wustl.edu] [27_1] [getAlignmentStats_generat
eStats_000] cmdline:  /opt/conda/share/manta-1.4.0-1/libexec/GetAlignmentStats --ref /cromwell-executions/SomaticSV.cwl/e9aaa9c2-6afc-4f4e-bf7e-cd706c0c7c50/call-SomaticSV.cwl/in
puts/593015123/GRCh38_full_analysis_set_plus_decoy_hla.fa --output-file /cromwell-executions/SomaticSV.cwl/e9aaa9c2-6afc-4f4e-bf7e-cd706c0c7c50/call-SomaticSV.cwl/execution/outpu
t/workspace/alignmentStats.xml.tmpdir/alignmentStats.xml.000.xml --align-file /cromwell-executions/SomaticSV.cwl/e9aaa9c2-6afc-4f4e-bf7e-cd706c0c7c50/call-SomaticSV.cwl/inputs/14
66789091/CPT0008550002.cram
```
 -> was CWL updated to accept CRAM?  No, it was not.
 -> get CWL edits from TinDaisy 
