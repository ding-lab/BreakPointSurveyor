# Get discordant read pair positions

# Writes dat/BPC/BAR.Discordant.BPC.dat for each sample

source ./Discordant.config

LIST="$BPS_DATA/A_Project/dat/TCGA_Virus.samples.dat"

OUTDD="$OUTD/BPC"
mkdir -p $OUTDD

while read l; do
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB
BAR=`echo $l | awk '{print $1}'`
DAT_FN="$OUTD/discordant_$BAR.sam"

OUT="$OUTDD/${BAR}.Discordant.BPC.dat"

# (we cast chrom name into string with $1"" so that string comparison is used)
# SAM file specs: 3:RNAME, 4:POS, 7:RNEXT, 8:PNEXT
# Note that a discordant read is listed twice for each read pair, so we keep only one

awk 'BEGIN{FS="\t";OFS="\t"}{if ($3"" <= $7"") print $3,$4,$7,$8}' $DAT_FN | sort > $OUT

echo Written to $OUT

done < $LIST

