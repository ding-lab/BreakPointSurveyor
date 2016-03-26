# Prioritize clusters based on number of breakpoints

source ./PlotList.config
# Retain top 5 clusters per sample to use to create PlotList
NCLUST=5

DATA_LIST="$BPS_DATA/A_Project/dat/1000SV.samples.dat"

mkdir -p $OUTD

while read l; do  # iterate over all barcodes
    # barcode bam_path    CTX_path
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    DAT="$OUTD/${BAR}.CTX-cluster.BPR.dat"
    OUT="$OUTD/${BAR}.prioritized.BPR.dat"

    head -n1 $DAT > $OUT
    grep -v barcode $DAT | sort -k7 -nr | head -n $NCLUST >> $OUT

    echo Written to $OUT

done < $DATA_LIST  # iterate over all barcodes

