
source ./Project.config

OUT="$OUTD/merged.fa"

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

OUT1="$OUTD/seg1.fa"
OUT2="$OUTD/seg2.fa"

get_FASTA $SEG1 "$OUTD/seg1.fa"
get_FASTA $SEG2 "$OUTD/seg2.fa"

paste -d ''  $OUT1 $OUT2 > $OUT

echo Written to $OUT
