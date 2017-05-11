# Create synthetic reads based on FASTA file

source ./BPS_Stage.config

# wgsim is distributed with samtools
WGSIM="wgsim"
# wgsim [options] <in.ref.fa> <out.read1.fq> <out.read2.fq>
# Make reads be 126bp in length
# simulate 80X coverage over 20Kbp sample ->
#   20,000 * 80 / 126 = 12.7K reads

NREADS=15000

ARGS="-N $NREADS -1 126 -2 126"

EVENT="IntraA"

DAT="$OUTD/${EVENT}.fa"
OUT1="$OUTD/${EVENT}.reads1.fq"
OUT2="$OUTD/${EVENT}.reads2.fq"

$WGSIM $ARGS $DAT $OUT1 $OUT2

echo Written to $OUT1 and $OUT2
