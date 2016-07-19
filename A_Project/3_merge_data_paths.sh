# Merge BAM and SAM data paths

# set +o posix
source ./Project.config

BAM="$OUTD/bam_path.dat"
SAM="$OUTD/sam.dat"

OUT="$OUTD/TCGA_Virus.samples.dat"

join $BAM $SAM | tr  ' ' '\t' > $OUT

# More joins can be chained like this:
#join $BAM $CTX | join - $PIN | tr ' ' '\t' > $OUT


echo Written to $OUT
