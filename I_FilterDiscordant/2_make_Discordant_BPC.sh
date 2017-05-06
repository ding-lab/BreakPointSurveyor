# Get discordant read pair positions and forward/reverse attributes

# Writes dat/BPC/BAR.Discordant.BPC.dat for each sample

# Removes the following "chromosomes":
# - *_alt
# - *_decoy
# - *_random
# - chrUn_
# - HLA-

source ./BPS_Stage.config

# We are not tracking this data due to size
U_DATD="dat.untracked"

OUTDD="$OUTD/BPC"
mkdir -p $OUTDD

while read l; do
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB
BAR=`echo $l | awk '{print $1}'`
DAT_FN="$U_DATD/filtered_discordant_$BAR.sam"

OUT="$OUTDD/${BAR}.Discordant.BPC.dat"

# SAM file specs: 2: FLAG, 3:RNAME, 4:POS, 7:RNEXT, 8:PNEXT
# forward/reverse given by FLAG bitwise_and 16.  See https://samtools.github.io/hts-specs/SAMv1.pdf and https://broadinstitute.github.io/picard/explain-flags.html

awk 'BEGIN{FS="\t";OFS="\t"}{if (and($2, 16)) d = "Reverse"; else d = "Forward"; print $3,$4,$7,$8,d}' $DAT_FN | grep -v "_alt\|_decoy\|_random\|chrUn_\|HLA-" | sort > $OUT

echo Written to $OUT

done < $SAMPLE_LIST

