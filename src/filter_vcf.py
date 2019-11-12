import argparse
from cyvcf2 import VCF, Writer

parser = argparse.ArgumentParser()
parser.add_argument("input")
parser.add_argument("output")
args = parser.parse_args()

vcf = VCF(args.input)
w = Writer(args.output, vcf)
for v in vcf:
    if v.FILTER is None:
        w.write_record(v)

w.close()
vcf.close()
