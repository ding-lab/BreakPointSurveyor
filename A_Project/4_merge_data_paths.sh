# Merge BAM and SV data paths to create per-sample list of BAM and CTX data files.

# Writing to TCGA_SARC.samples.dat

set +o posix

BAMS="dat/TCGA_SARC.bam_path.dat"
SV="dat/TCGA_SARC.somatic_variation.dat"

OUT="dat/TCGA_SARC.samples.dat"

# 1) write header
# 2) append path to SV variants file to SV data
# 3) merge BAM and SV by barcode

echo -e "barcode\tbam_path\tCTX_path" > $OUT

join $BAMS <(sed 's/$/\/variants\/svs.hq/' $SV) | tr ' ' '\t' >> $OUT

echo Written to $OUT
