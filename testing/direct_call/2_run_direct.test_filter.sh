# not fully implemented. designed to test filter script directly

VCF="output/results/variants/somaticSV.vcf.gz"

OVCF="output/results/variants/final.SV.WGS.vcf"

/usr/bin/python /usr/local/SomaticSV/src/filter_vcf.py $VCF $OVCF

echo Written to $OVCF


