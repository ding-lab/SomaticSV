# HNSCC WGS CRAMs

## Understanding UMich HNSCC data

Downloaded via globus, visible on katmai at:
    /home/mwyczalk_test/Projects/RIS/mnt/Active/CPTAC3.share/cords-align

CPT0261640002 is the name of an aliquot corresponding to case C3N-04611 (basing this on our CPTAC3.Catalog.dat catalog)
The actual filename was CPT0261640002.WholeGenome.RP-1303.bam

We followed these recommendations, regarding reference and tools / parameters:
    https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6168605/

We used a GRCh38 reference that includes alternative contigs and HLA haplotypes
(I prefer this over the GDC reference incorrectly included decoys without
including alternate haplotypes).

The bam file is sorted, with indel realignment, and computed statistics for
base quality recalibration. Importantly duplicates are not marked (our
pipelines are setup to do duplicate removal for compatibility with some
downstream tools, we compute those on the fly and do not store).

Reference downloaded and available at,
    /home/mwyczalk_test/Projects/RIS/mnt/Active/Resources/References/GRCh38_full_analysis_set_plus_decoy_hla/GRCh38_full_analysis_set_plus_decoy_hla.fa


## Modifications to CWL to accommodate CRAMs

From John Garza

expanding on that just a little- most of our tools will accept either format as
an input and work with no additional flags; cwl only goes as far as checking
that the input is a file, not the type/extension, so it doesnt care

with that said, many require index files to be alongside the bam/cram, which is
specified using the CWL secondaryFiles option, which does change depending on
the file type

to get around that, some of our tools use this construct: (from
analysis-workflows/definitions/tools/manta_somatic.cwl )
```
    normal_bam:
        type: File?
        inputBinding:
            position: -2
            prefix: "--normalBam"
        secondaryFiles: ${if (self.nameext === ".bam") {return self.basename + ".bai"} else {return self.basename + ".crai"}}
```
using the `--normalBam` flag. this tool can accept either bam or cram, but the
secondaryFile specifying the index must be <seq_name>.bam.bai for bams and
<seq_name>.cram.crai for crams, so we use an expression
some tools will expect the index to be named like `<seq_name>.bai/.crai`
For these replace self.basename  with self.nameroot  in that expression

## Making BamMap

CRAM files live on storage1.  On katmai, these are mounted here:
    /home/mwyczalk_test/Projects/RIS/mnt/Active/CPTAC3.share/cords-align/

Need to create a BamMap file which maps to these.  CromwellRunner README.md file has details about
BamMaps and how to make them for non-GDC-download data. To wit,

BamMap is a tab-separated file with the following columns:
```
BamMap columns
1  sample_name                  ---
2  case                         ***
3  disease                      ---
4  experimental_strategy        ***
5  sample_type                  ***
6  data_path                    ---
7  filesize
8  data_format
9  reference                    ***
10  UUID                        ---
11  system
```
Fields marked `***` are used to find the appropriate sample, and fields marked `---` are then read.

Non-CPTAC3 data will typically not have a BamMap constructed as above.  It is possible to make a synthetic BamMap by generating fields as follows:
* `sample_name` is an arbitrary human-readable name for this sample.  Example: `C3L-00032.WXS.T.hg38`
* `case` is unique name of this subject
* `disease` is an arbitrary disease code
* `experimental_strategy` takes the values `WXS`, `WGS`, `RNA-Seq`, or `miRNA-Seq`
* `sample_type` takes the values `tumor`, `tissue_normal`, `blood_normal`.
* `data_path` is the full path to the sequence data (BAM file).  Note that the index file must be available as the BAM path with `.bai` appended
* `reference` is typically `hg19` or `hg38`, though other values can be used
* `UUID` is a unique identifier of a specific sample.  It need not be used

BamMap is created by `0_make_BamMap.sh` and written to dat/BamMap.HNSCC.UMich.dat

dat/cases.dat is created from BamMap


# Processing steps

* Edit project_config.sh
  *  Here, CASES="./dat/LSCC.WGS.not_processed_case.dat"

* Test YAML file creation with,
    bash 1_make_yaml.sh -1
  This will process once case and stop.  Examine YAML file closely, confirming paths and BAM file attributes
* Create all YAML files with,
    bash 1_make_yaml.sh 

* Inspect one job command
    bash 2_run_tasks.sh -1d
* Optionally, run one job to test
    bash 2_run_tasks.sh -1

* Optionally start tmux session 
*  -> currently, running on sitka

* Start five jobs at a time
    bash 2_run_tasks.sh -J 5

## Run updates

Started on Sitka with `-J 5` as described above on 12/31/19 around 12:30pm
tmux session somatic_sv
