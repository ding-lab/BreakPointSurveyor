source ./BPS_Stage.config

# Prepare chr9+chr22 reference for alignment
# * merge the chr9 and chr22 .fa files
# * Generate fai file

UNTRACKED_DIR=$OUTD

OUT=$UNTRACKED_DIR/reference.chr9_chr22.fa
cat $UNTRACKED_DIR/chr9.fa $UNTRACKED_DIR/chr22.fa > $OUT

samtools faidx $OUT

$BWA index $OUT
