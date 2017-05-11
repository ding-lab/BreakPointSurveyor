# Get discordant read pair positions

# Writes dat/BPC/BAR.Discordant.BPC.dat for each sample

# Removes the following "chromosomes":
# - *_alt
# - *_decoy
# - *_random
# - chrUn_
# - HLA-

source ./BPS_Stage.config

OUTDD="$OUTD/BPC"
mkdir -p $OUTDD

function SAMtoBPC {
# (we cast chrom name into string with $1"" so that string comparison is used)
# SAM file specs: 3:RNAME, 4:POS, 7:RNEXT, 8:PNEXT
# Note that a discordant read is listed twice for each read pair, so we keep only one
# This version also deals with intrachromosomal discordant reads, where chromA=chromB, where we require that posA < posB

# forward/reverse given by FLAG bitwise_and 16.  See https://samtools.github.io/hts-specs/SAMv1.pdf and https://broadinstitute.github.io/picard/explain-flags.html

DAT=$1
OUT=$2

awk 'BEGIN{FS="\t";OFS="\t"}{if (and($2, 16)) d = "Reverse"; else d = "Forward"; if ($3"" <= $7"") print $3,$4,$7,$8,d; else if ($7 ~ "=") {if ($4 < $8) print $3,$4,$3,$8,d} }' $DAT | grep -v "_alt\|_decoy\|_random\|chrUn_\|HLA-" | sort > $OUT

echo Written to $OUT

}

while read l; do
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB
BAR=`echo $l | awk '{print $1}'`

# First do inter-chromosomal discordant
DAT="$OUTD/discordant_$BAR.sam"
OUT="$OUTDD/${BAR}.Discordant.BPC.dat"
SAMtoBPC $DAT $OUT

# Now do intra-chromosomal discordant
DAT="$OUTD/intraDiscordant_$BAR.sam"
OUT="$OUTDD/${BAR}.IntraDiscordant.BPC.dat"
SAMtoBPC $DAT $OUT

done < $SAMPLE_LIST

