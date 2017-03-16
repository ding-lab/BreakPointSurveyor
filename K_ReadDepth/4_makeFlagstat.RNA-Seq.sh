# Generate flagstat files summarizing BAM read counts for RNA-Seq data.
# See 2_makeFlagstat.sh for details

source ./ReadDepth.config

RNA_SAMPLE_LIST="$BPS_DATA/C_Project/dat/RNA-Seq.samples.dat"

OUTDD="$OUTD/flagstat"
mkdir -p $OUTDD

function make_flagstat {
    BAR=$1
    BAM=$2

    FLAGSTAT="$BAM.flagstat"  # see if this exists
    OUT="$OUTDD/${BAR}.flagstat"

    if [ -f $FLAGSTAT ]; then
        echo "FLAGSTAT file for $BAR exists."
        echo "Copying to $OUT"
        cp $FLAGSTAT $OUT
    else
        echo "Creating FLAGSTAT for $BAR..."
        samtools flagstat $BAM > $OUT
        echo Written to $OUT
    fi
}

while read l; do
# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
BAM=`echo "$l" | cut -f 3`

#echo Processing flagstat $BAR $BAM

make_flagstat $BAR $BAM

done < $RNA_SAMPLE_LIST

