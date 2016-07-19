# Get discordant read pair positions

# Writes dat/BAR.Discordant.BPC.dat for each sample

source ./Discordant.config

DATA_LIST="$OUTD/TCGA_Virus.Discordant.dat"
echo Data list: $DATA_LIST

while read l; do
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# first we write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB
BAR=`echo $l | awk '{print $1}'`
DAT_FN=`echo $l | awk '{print $2}'`   

OUT="$OUTD/${BAR}.Discordant.BPC.dat"

echo $DAT_FN
# (we cast chrom name into string with $1"" so that string comparison is used)
# SAM file specs: 3:RNAME, 4:POS, 7:RNEXT, 8:PNEXT
awk 'BEGIN{FS="\t";OFS="\t"}{if ($3"" <= $7"") print $3,$4,$7,$8; else print $7,$8,$3,$4}' $DAT_FN | sort > $OUT
#grep CTX $CTX_FN | awk 'BEGIN{FS="\t";OFS="\t"}{if ($1"" <= $4"") print $1,$2,$4,$5; else print $4,$5,$1,$2}' | sort > $OUT

echo Written to $OUT

done < $DATA_LIST

