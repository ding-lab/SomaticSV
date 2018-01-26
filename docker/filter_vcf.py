import argparse
from os.path import splitext, basename
from cyvcf2 import VCF, Writer

parser = argparse.ArgumentParser()
parser.add_argument("input")
args = parser.parse_args()

vcf = VCF(args.input)
root, ext = splitext(basename(args.input))
w = Writer("{0}.filtered{1}".format(root, ext), vcf)
for v in vcf:
    if v.FILTER is None:
        w.write_record(v)

w.close()
vcf.close()
