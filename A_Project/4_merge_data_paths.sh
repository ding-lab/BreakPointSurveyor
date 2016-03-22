# Merge BAM, CTC, and Pindel_RP data paths
# only samples with all three datasets retained

# Writing to $OUTD/1000SV.samples.dat

# set +o posix
source ./A_Project.config

BAM="$OUTD/1000SV.bam_path.dat"
CTX="$OUTD/1000SV.CTX.dat"
PIN="$OUTD/1000SV.Pindel_RP.dat"

OUT="$OUTD/1000SV.samples.dat"

echo -e "barcode\tbam_path\tCTX_path\tPindel_path" > $OUT

join $BAM $CTX | join - $PIN | tr ' ' '\t' >> $OUT

echo Written to $OUT
