# Using PERL

source ./BPS_Stage.config
set +o posix

OUT="$OUTD/IntraA.fa"

BIN="../C_SyntheticBAM/src/get_FASTA.pl"

#Consists of three concatenated segments AC'B, where
#* Segment A : chr9:130,840,000-130,850,000 ( 10Kbp )
#* Segment B : chr9:130,850,000-130,860,000 ( 10KBp, adjacent to A )
#* Segment C : chr9:131,855,000-131,860,000 ( 5Kbp, some other region of chrom 9 )
#    * Segment C' : reverse complement of Segment C

function get_FASTA {
SEG=$1
OUTMP=$2
perl $BIN $SEG > $OUTMP
}

SEGA="chr9:36833000,36843000"
SEGB="chr9:36843000,36853000"
SEGC="chr9:37843000,37853000"

OUTA="$OUTD/SegA.tmp.fa"
OUTB="$OUTD/SegB.tmp.fa"
OUTC="$OUTD/SegC.tmp.fa"
OUTCr="$OUTD/SegCr.tmp.fa"

get_FASTA $SEGA $OUTA
get_FASTA $SEGB $OUTB
get_FASTA $SEGC $OUTC
cat $OUTC | rev | tr ATGC TACG > $OUTCr  # http://biocozy.blogspot.com/2013/03/command-line-reverse-complement.html

# On Mac, seems like you need '\0' instead of ''
paste -d '\0'  $OUTA $OUTCr $OUTB > $OUT

echo Written to $OUT
