source ./Reference.config

# Prepare chr9+chr22 reference for alignment
# * merge the chr9 and chr22 .fa files
# * Generate fai file

OUT=$OUTD/reference.chr9_chr22.fa
cat $OUTD/chr9.fa $OUTD/chr22.fa > $OUT

samtools faidx $OUT

BWA="$HOME/pkg/bwa-0.7.15/bwa"

$BWA index $OUT
