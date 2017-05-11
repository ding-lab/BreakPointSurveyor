# Using PERL

source ./BPS_Stage.config

OUT="$OUTD/synthetic.fa"

BIN="src/get_FASTA.pl"

function get_FASTA {
SEG=$1
OUTMP=$2

perl $BIN $SEG > $OUTMP
#echo Written to $OUTMP

}

# Segment 1: chr9:130,840,000-130,850,000 
# Segment 2: chr22:23,260,000-23,270,000
SEG1="chr9:130840000,130850000"
SEG2="chr22:23260000,23270000"

OUT1="$OUTD/synthetic1.fa"
OUT2="$OUTD/synthetic2.fa"

get_FASTA $SEG1 $OUT1
get_FASTA $SEG2 $OUT2

paste -d ''  $OUT1 $OUT2 > $OUT

echo Written to $OUT
