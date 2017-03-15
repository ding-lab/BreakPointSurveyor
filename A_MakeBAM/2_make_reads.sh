# Create synthetic reads based on FASTA file

source ./Project.config

# wgsim is distributed with samtools
BIN="wgsim"
# wgsim [options] <in.ref.fa> <out.read1.fq> <out.read2.fq>
# Make reads be 126bp in length
# simulate 80X coverage over 20Kbp sample ->
#   20,000 * 80 / 126 = 12.7K reads

NREADS=15000

ARGS="-N $NREADS -1 126 -2 126"

DAT="$OUTD/merged.fa"
OUT1="$OUTD/out.read1.fq"
OUT2="$OUTD/out.read2.fq"

$BIN $ARGS $DAT $OUT1 $OUT2

echo Written to $OUT1 and $OUT2
