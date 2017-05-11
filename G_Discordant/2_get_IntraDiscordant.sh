# Extract all intrachromosomal discordant reads with mapping quality > 25
# Intrachromosomal discordant reads are defined here as those with a mapping position difference > 100,000
MAXD=100000

source ./BPS_Stage.config

function process {
    BAR=$1
    BAM=$2

    # process BAM to get just the discordant reads (written to OUT)
    OUT="$OUTD/intraDiscordant_$BAR.sam"

    # SAM specs: https://samtools.github.io/hts-specs/SAMv1.pdf
    # col 5 is MAPQ of read
    # col 7 is RNEXT.  If RNEXT is "=", it is the same as mate, and may be intrachromosomal discordant

    # keeping just high quality discordant reads

    echo Processing $BAR

#awk -v maxd=$MAXD 'BEGIN{FS="\t";OFS="\t"}{if (($3 == $7) && (abs($8 - $4) > maxd)) print $3,$4,$7,$8}' $DAT_FN | sort > $OUT
    #samtools view  $BAM | awk -v mapq=$MAPQ -v maxd=$MAXD 'BEGIN{FS="\t"} {if (($7 ~ /=/) && ($5 >= mapq) && (abs($8 - $4) > maxd))  print}' > $OUT
    samtools view  $BAM | awk -v mapq=$MAPQ -v maxd=$MAXD 'function abs(v) {return v < 0 ? -v : v} BEGIN{FS="\t"} {if (($7 ~ /=/) && ($5 >= mapq) && (abs($8 - $4) > maxd))  print}' > $OUT
    # samtools view  $BAM | awk -v mapq=$MAPQ -v maxd=$MAXD 'function abs(v) {return v < 0 ? -v : v} BEGIN{FS="\t"} {print $4, $8, abs($8 - $4) }' > $OUT
    echo Written to $OUT

}

while read l
do
    # Skip comments and header
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    BAM=`echo $l | awk '{print $3}'`

    process $BAR $BAM
done < $SAMPLE_LIST 


