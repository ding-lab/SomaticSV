# Somatic SV Workflow
With modifications for CWL integration

Contact Matt Wyczalkowski (m.wyczalkowski@wustl.edu) with questions

## SV Caller
- Manta 1.4.0
- Filters: Only select the variants which pass the following criteria:
    - Sample site depth is less than 3x the median chromosome depth near one or both variant breakends
    - Somatic score is greater than 30
    - For a small variant (<1000 bases) in the normal sample, the fraction of reads with MAPQ0 around either breakend doesn't exceed 0.4

# Run Notes

There are a number of ways to run SomaticSV workflow, as discussed in Development Notes below.  The following instructions
are for running SomaticSV using Rabix Executor using a simple task manager, developed specifically for CPTAC3 analyses.

## Installation

**[Install Docker](https://www.docker.com/community-edition)**
Be sure it is running before running `rabix`.

**[Install Rabix Executor](http://rabix.io/)**
```
wget https://github.com/rabix/bunny/releases/download/v1.0.5-1/rabix-1.0.5.tar.gz -O rabix-1.0.5.tar.gz && tar -xvf rabix-1.0.5.tar.gz
```

Test Rabix Executor with,
```
cd rabix-cli-1.0.5
./rabix examples/dna2protein/dna2protein.cwl.json examples/dna2protein/inputs.json
```
This should run for a few seconds and then produce output like,
```
[2018-04-20 14:38:24.655] [INFO] Job root.Translate has completed
{
  "output_protein" : {
    "basename" : "protein.txt",
    "checksum" : "sha1$55adf0ec2ecc6aee57a774d48216ac5a97d6e5ba",
    "class" : "File",
    "contents" : null,
    "dirname" : "/Users/mwyczalk/tmp/tin-daisy/rabix-cli-1.0.5/examples/dna2protein/dna2protein.cwl-2018-04-20-143817.231/root/Translate",
    "format" : null,
    "location" : "file:///Users/mwyczalk/tmp/tin-daisy/rabix-cli-1.0.5/examples/dna2protein/dna2protein.cwl-2018-04-20-143817.231/root/Translate/protein.txt",
    "metadata" : null,
    "nameext" : ".txt",
    "nameroot" : "protein",
    "path" : "/Users/mwyczalk/tmp/tin-daisy/rabix-cli-1.0.5/examples/dna2protein/dna2protein.cwl-2018-04-20-143817.231/root/Translate/protein.txt",
    "secondaryFiles" : [ ],
    "size" : 9
  }
}
```

**Install [SomaticSV](https://github.com/mwyczalkowski/somatic_sv_workflow.git)**
```
git clone https://github.com/mwyczalkowski/somatic_sv_workflow.git
```

The following packages are also required for the simple task manager:
* [`jq`](https://stedolan.github.io/jq/download/)
* [`GNU Parallel`](https://www.gnu.org/software/parallel/)

## Running CPTAC3 analyses

Example of CPTAC3 analyses is in `demo/task_call/katmai.C3`.  Scripts in this directory can be modified in place, or copied and modified in another directory.

### 1. Edit `project_config.sh`
The `project_config.sh` file has all paths and other definitions specific to a given system (e.g., katmai) and project (e.g., GRCh38 CPTAC3 data).  In particular,
need to specify path to BamMap file and other details described there.

### 2. Create `dat/cases.dat` file
This file has list of all case names which will be analyzed as part of this project.  Case names (e.g., C3L-00001) must be unique in this file, and must
match the case names in the BamMap file.

### 3. Run `1_make_yaml.sh`
This generates a series of YAML files, which provide inputs to Rabix (and Cromwell) CWL workflow managers, one per case.  This script also
creates file `dat/analysis_pre-summary.dat`, which is used to report analysis results once they are complete.

### 4. Run `2_run_tasks.sh`
This launches the SomaticSV workflow using Rabix, either one at a time (default) or several at a time using `GNU parallel`.  For the latter,
invoke as,
```
2_run_tasks.sh -J 4
```
if you wish to run four at a time.  The dry run flag (`-d`) is useful for testing of configuration.

This step will write results to two places specified in `project_config.sh`: `LOGD` and `RABIXD`.  Watch `LOGD/CASE.err` for execution progress

### 5. Run `3_make_analysis_summary.sh`
When analysis completes, this step will create an analysis summary file which reports on the path to the output VCF file per case, and the 
input files which were used to generate it.


# Development notes
## Demo data

For development and testing purposes, we distribute Demo data obtained from [Manta distribution](https://github.com/Illumina/manta/tree/master/src/demo/data)
in `demo/demo_data` directory, consisting of small tumor/normal BAM files and a reference.  Prior to testing, need to uncompress
the reference with,
```
tar -xvjf Homo_sapiens_assembly19.COST16011_region.fa.tar.bz2
```

## Demo projects
`./demo` directory contains example runs with the workflow executed directly (i.e., inside docker container), by calling docker, and by calling CWL (Rabix and Cromwell).

