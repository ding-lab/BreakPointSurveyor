# Using PERL

source ./BPS_Stage.config
set +o posix

OUT="$OUTD/IntraA.fa"

BIN="src/get_FASTA.pl"

#Consists of three concatenated segments AC'B, where
#* Segment A : chr9:130,840,000-130,850,000 ( 10Kbp )
#* Segment B : chr9:130,850,000-130,860,000 ( 10KBp, adjacent to A )
#* Segment C : chr9:131,855,000-131,860,000 ( 5Kbp, some other region of chrom 9 )
#    * Segment C' : reverse sequence of Segment C

function get_FASTA {
SEG=$1
OUTMP=$2
perl $BIN $SEG > $OUTMP
}

SEGA="chr9:130840000,130850000"
SEGB="chr9:130840000,130850000"
SEGC="chr9:130840000,130850000"

OUTA="$OUTD/SegA.tmp.fa"
OUTB="$OUTD/SegB.tmp.fa"
OUTC="$OUTD/SegC.tmp.fa"
OUTCr="$OUTD/SegCr.tmp.fa"

get_FASTA $SEGA $OUTA
get_FASTA $SEGB $OUTB
get_FASTA $SEGC $OUTC
cat $OUTC | rev > $OUTCr

# On Mac, seems like you need '\0' instead of ''
paste -d '\0'  $OUTA $OUTCr $OUTB > $OUT

echo Written to $OUT
