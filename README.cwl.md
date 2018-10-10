Goal here is to wrap Manta-based SV caller developed by Wen-Wei Liao into CWL container.

# Past work

* Using CPTAC3.b4 as a model: /gscmnt/gc2741/ding/wliao/CPTAC3/CPTAC3.b4
* See also Somatic SV Workflow on [github](https://github.com/ding-lab/somatic_sv_workflow/tree/v0.2)

## CPTAC3.b4 workflow details

Examining code, 3 step process:
* `get_pairs.py`: parses BamMap file and generates SampleList file `CPTAC3_b4_WGS_Tumor_Normal_Pairs.txt`
* `bsub_manta.sh`: Loops each entry in SampleList and calls,
    * `bsub run_manta.sh $tumor $normal $ref $sample`
    * `run_manta.sh`: script to run `configManta.py` and `runWorkflow.py`, which calls the Manta executable
        * Writes output in ./$sample and $sample.manta.log
* `filter_vcf.py`: iterates over all output directories.  For each,
    * Reads file `results/variants/somaticSV.vcf.gz`, and writes file ending with `SV.WGS.vcf`
        * Output file retains only those reads for which variant.FILTER is None

### Data files

* `CPTAC3_b4_WGS_Tumor_Normal_Pairs.txt` (SampleList)
     * columns are case, tumor BAM, normal BAM paths
     * 47 rows
     * Split into two runs, run_1.txt and run_2.txt

# Development notes
```
Configuration cmd: "/opt/conda/share/manta-1.4.0-1/bin/configManta.py" 
--normalBam="/opt/conda/share/manta-1.4.0-1/share/demo/manta/data/HCC1954.NORMAL.30x.compare.COST16011_region.bam" 
--tumorBam="/opt/conda/share/manta-1.4.0-1/share/demo/manta/data/G15512.HCC1954.1.COST16011_region.bam" 
--referenceFasta="/opt/conda/share/manta-1.4.0-1/share/demo/manta/data/Homo_sapiens_assembly19.COST16011_region.fa" 
--region=8:107652000-107655000 
--region=11:94974000-94989000 
--candidateBins=4 
--exome 
--runDir="MantaDemoAnalysis"
```
