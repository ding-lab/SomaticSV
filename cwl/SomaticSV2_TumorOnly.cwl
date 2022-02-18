class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: somatic_sv2_tumor_only
baseCommand:
  - /bin/bash
  - /usr/local/SomaticSV/src/process_SomaticSV.sh
inputs:
  - id: tumor
    type: File
    inputBinding:
      position: 1
      prefix: '-t'
    label: Tumor BAM
    secondaryFiles:
      - >-
        ${if (self.nameext === ".bam") {return self.basename + ".bai"} else
        {return self.basename + ".crai"}}
  - id: reference
    type: File
    inputBinding:
      position: 3
      prefix: '-r'
    label: Reference FASTA
    secondaryFiles:
      - .fai
  - id: generateEvidenceBam
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-C "--generateEvidenceBam"'
    label: generateEvidenceBam
    doc: Pass --generateEvidenceBam to Manta configuration
  - id: dryrun
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-d'
    label: dry run
    doc: 'Print out commands but do not execute, for testing only'
outputs:
  - id: candidateSmallIndels
    type: File
    outputBinding:
      glob: output/results/variants/results/variants/candidateSmallIndels.vcf.gz
    secondaryFiles:
      - .tbi
  - id: output_evidence
    type:
      - 'null'
      - File
      - type: array
        items: File
    outputBinding:
      glob: output/results/evidence/*.bam
    secondaryFiles:
      - .bai
  - id: candidateSV
    type: File
    outputBinding:
      glob: output/results/variants/candidateSV.vcf.gz
    secondaryFiles:
      - .tbi
  - id: tumorSV
    type: File
    outputBinding:
      glob: output/results/variants/tumorSV.vcf.gz
    secondaryFiles:
      - .tbi
label: Somatic_SV2_TumorOnly
requirements:
  - class: ResourceRequirement
    ramMin: 8000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/somatic_sv:20220217'
  - class: InlineJavascriptRequirement
