class: CommandLineTool
cwlVersion: v1.0
id: somatic_sv_workflow
baseCommand:
  - /bin/bash
  - /usr/local/SomaticSV/src/process_sample.sh
inputs:
  - id: tumor
    type: File
    inputBinding:
      position: 1
    label: Tumor BAM
    secondaryFiles:
      - >-
        ${if (self.nameext === ".bam") {return self.basename + ".bai"} else
        {return self.basename + ".crai"}}
  - id: normal
    type: File
    inputBinding:
      position: 2
    label: Normal BAM
    secondaryFiles:
      - >-
        ${if (self.nameext === ".bam") {return self.basename + ".bai"} else
        {return self.basename + ".crai"}}
  - id: reference
    type: File
    inputBinding:
      position: 3
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
  - id: output
    type: File?
    outputBinding:
      glob: output/results/variants/final.SV.WGS.vcf
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
label: Somatic_SV_Workflow
requirements:
  - class: ResourceRequirement
    ramMin: 8000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/somatic_sv:20200518'
  - class: InlineJavascriptRequirement
