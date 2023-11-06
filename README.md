# Somatic SV Workflow
With modifications for CWL integration

Contact Matt Wyczalkowski (m.wyczalkowski@wustl.edu) with questions

## Versions
Versions are those indicated in DCC Analysis Summary for CPTAC3 project

## Version 2.0
* Associated with image `mwyczalkowski/somatic_sv:20220217`
* Manta 1.6.0
* Support for tumor/normal and tumor-only modes
* Files returned, currently unfiltered:
  * Tumor-normal
    * `candidateSmallIndels.vcf.gz`
    * `candidateSV.vcf.gz`
    * `diploidSV.vcf.gz`
    * `somaticSV.vcf.gz`
  * Tumor-only
    * `candidateSmallIndels.vcf.gz`
    * `candidateSV.vcf.gz`
    * `tumorSV.vcf.gz`

## Version 1.2
* Associated with CWL file "SomaticSV.cwl"
  * this is the version used for CPTAC3 processing
* Docker image: mwyczalkowski/somatic_sv:20200518
* Manta 1.6.0
* Filters: Only select the variants from somaticSV.vcf.gz output which pass the following criteria:
    * Sample site depth is less than 3x the median chromosome depth near one or both variant breakends
    * Somatic score is greater than 30
    * For a small variant (<1000 bases) in the normal sample, the fraction of reads with MAPQ0 around either breakend doesn't exceed 0.4
* BAM files `evidence_0` and `evidence_1` generated with Manta argument `--generateEvidenceBam`

## Version 1.1
* Manta 1.4.0 with tumor and normal sequence data
* Filtering as in v1.2, no BAM evidence files returned

# Run Notes

In general, SomaticSV is run using [CromwellRunner](https://github.com/ding-lab/CromwellRunner.git)

Install [SomaticSV](https://github.com/ding-lab/SomaticSV.git)
```
git clone --recurse-submodules https://github.com/ding-lab/SomaticSV.git
```

# Development notes
## Demo data
For development and testing purposes, we distribute Demo data obtained from [Manta distribution](https://github.com/Illumina/manta/tree/master/src/demo/data)
in `demo/demo_data` directory, consisting of small tumor/normal BAM files and a reference.  Prior to testing, need to uncompress
the reference with,
```
tar -xvjf Homo_sapiens_assembly19.COST16011_region.fa.tar.bz2
```



[GitHub](https://github.com/ding-lab/SomaticSV.git)
Contact Matt Wyczalkowski (m.wyczalkowski@wustl.edu) with questions
