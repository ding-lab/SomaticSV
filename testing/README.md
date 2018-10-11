Several levels of calls available for testing
* direct_call: Calling process_sample.sh directly from container
* docker: Instantiate docker container and call scripts within it
* cwl: Run either Rabix or Cromwell workflow engines to process somatic_sv_workflow.cwl

Before running Demo data, be sure to uncompress reference:
```
cd demo_data
tar -xvjf Homo_sapiens_assembly19.COST16011_region.fa.tar.bz2
```
