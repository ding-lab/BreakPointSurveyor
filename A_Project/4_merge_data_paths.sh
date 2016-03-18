# Merge BAM, CTC, and Pindel_RP data paths
# only samples with all three datasets retained

# Writing to 1000SV.samples.dat

# set +o posix

BAM="dat/1000SV.bam_path.dat"
CTX="dat/1000SV.CTX.dat"
PIN="dat/1000SV.Pindel_RP.dat"

OUT="dat/TCGA_SARC.samples.dat"

echo -e "barcode\tbam_path\tCTX_path\tPindel_path" > $OUT

join $BAM $CTX | join - $PIN | tr ' ' '\t' >> $OUT

echo Written to $OUT
