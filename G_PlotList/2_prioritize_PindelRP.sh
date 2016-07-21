# Prioritize PindelRP clusters based on number of breakpoints
# The idea is to focus on integration events with the most breakpoints in them.
# In practice this is not needed here, since none of the samples have
# more than 5 integration events.  Keeping this code all the same for future workflows.


source ./PlotList.config
# Retain top 5 clusters per sample to use to create PlotList
NCLUST=5

LIST="$BPS_DATA/A_Project/dat/TCGA_Virus.samples.dat"

mkdir -p $OUTD

OUTDD="$OUTD/BPR"

while read l; do  # iterate over all barcodes
    # barcode bam_path    CTX_path
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    DAT="$OUTDD/${BAR}.PindelRP-cluster.BPR.dat"
    OUT="$OUTDD/${BAR}.PindelRP-prioritized.BPR.dat"

    head -n1 $DAT > $OUT
    grep -v breakpointCount $DAT | sort -k7 -nr | head -n $NCLUST >> $OUT

    echo Written to $OUT

done < $LIST  # iterate over all barcodes

