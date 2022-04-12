Testing of file-based database functionality

# Background
Existing MGI Cromwell server API:
    https://genome-cromwell.gsc.wustl.edu/swagger/index.html?url=/swagger/cromwell.yaml#/Workflows
Note that querying a recent Workflow doesnt work (e.g., 52479b07-04e9-456d-bd35-1d9029941d4c from
/storage1/fs1/dinglab/Active/Projects/CPTAC3/Analysis/CromwellRunner/SomaticSV/16.GDAN_DLBCL-135/logs/stashed/52479b07-04e9-456d-bd35-1d9029941d4c/CTSP-AD02.ALQ_e4ddf5c7.WGS.T.LSF.out
doesnt work)


# Implementation
Takes place in `./testing/cwl_call/cromwell-simple-compute1`
Idea is to implement file database as described here (see "Using Cromwell with file-based database"):
    https://cromwell.readthedocs.io/en/stable/Configuring/
Testing with demo data to make this reasonably fast
Implementaion in config/cromwell-config-db.compute1-filedb.dat

Notes:
* Output goes to "cromwell-executions" directory relative to working directory.  
  * All content in `cromwell-executions/cromwell-db`
  * We will want to move this to scratch, specifically we want this as a line in database.db.url:
        jdbc:hsqldb:file:/scratch1/fs1/dinglab/m.wyczalkowski/cromwell-data/cromwell-workdir/cromwell-executions/cromwell-db/cromwell-db;

Check if there can be concurrent access to this database:
  * No.  If starting run1 and run2, run2 pauses until run1 finished
    

# Discussion and conclusion

FileDB requires one "database" per run.  As a consequence, necessary to assign different fileDB paths
for every Cromwell run.  Generally do not query database during run, but can connect to it at conclusionQuerying database is not possible .

TODO for implemeting FileDB functionality
* This is a good approach for testing, though MySQL database approaches may be better for production
* Will require per-run configuration files to be generated
  * These are re-used for querying database at a later time
* Will also need to implement "spinning up temporary cromwell instance" using same Cromwell configuration file
  to get timing, status, and other information about the run, as necessary
  * There are generally other ways to get status information such as parsing of logs
