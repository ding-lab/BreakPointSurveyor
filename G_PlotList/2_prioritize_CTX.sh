# Prioritize clusters based on number of breakpoints

# Retain top 5 clusters per sample to use to create PlotList
NCLUST=5

DATD="BPR"
DATA_LIST="../A_Project/dat/TCGA_SARC.samples.dat"

OUTD="BPR"
mkdir -p $OUTD

while read l; do  # iterate over all barcodes
    # barcode bam_path    CTX_path
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    DAT="$DATD/${BAR}.CTX-cluster.BPR.dat"
    OUT="$OUTD/${BAR}.prioritized.BPR.dat"

    head -n1 $DAT > $OUT
    grep -v barcode $DAT | sort -k7 -nr | head -n $NCLUST >> $OUT

    echo Written to $OUT

done < $DATA_LIST  # iterate over all barcodes

