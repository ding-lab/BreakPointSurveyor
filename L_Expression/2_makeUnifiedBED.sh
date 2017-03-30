# Create a BED file of exons of interest for each disease type
# this is just a concatenation of all beds of interest according to disease
# and is used to provide regions of interest for RPKM calculations
# Doing only human chrom (A unless FLIPAB=1) but Chrom B is supported
# Writes e.g., $DAT/BED/HNSC.roi.bed


source ./BPS_Stage.config

PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.50K.dat"
FLANKN="1M"

TMPD="$OUTD/tmp"
mkdir -p $TMPD
rm -f $TMPD/*

OUTDD="$OUTD/BED"
mkdir -p $OUTDD

# usage: sortBED DIS
function sortBED {
    DIS=$1
    DAT="$TMPD/${DIS}.tmp"
    OUT="$OUTDD/${DIS}.roi.bed"

    if [ ! -f $DAT ]; then
        echo $DAT unknown
        return
    fi

    bedtools sort -i $DAT | sed 's/^/chr/' | grep -v "PATCH" | cut -f 1-4 > $OUT
    echo Written to $OUT
}

function process {
    NAME=$1
    CHROM_ID=$2
    DIS=$3

    DAT="$OUTD/BED/${NAME}.${CHROM_ID}.${FLANKN}.bed"
    OUT="$TMPD/${DIS}.tmp"  # this would be same for chrom A and B, so that the BED files are merged
    if [ ! -f $DAT ]; then
        echo $DAT does not exist.  Skipping.
        continue
    fi
    cat $DAT >> $OUT
}

while read l
do
#barcode name    chrom.A event.A.start   event.A.end range.A.start   range.A.end chrom.B event.B.start   event.B.end range.B.start   range.B.end
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
    BAR=`echo "$l" | cut -f 1`
    NAME=`echo "$l" | cut -f 2`     

    DIS=`grep $BAR $SAMPLE_LIST | cut -f 2`

# Note that we're only considering chrom A, which is human in human/virus events (unless FLIPAB=1)
    if [ $FLIPAB == 1 ]; then  # see ../bps.config
        process $NAME B $DIS
    else
        process $NAME A $DIS
    fi

done < $PLOT_LIST

#sortBED BLCA
sortBED HNSC

