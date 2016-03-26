# Cluster nearby CTX breakpoints 

# Create BPR file which has regions of clustered CTX breakpoint events.
# Such events are per unique chromA/chromB pair
# In makeBreakpointRegions.py we combine into one region all breakpoints on chrom A as well as those on chrom B
# which are within a distance D from each other along both chromosomes.

# Last column of BPR file is number of CTX breakpoints in cluster

source ./PlotList.config

BIN="$BPS_CORE/src/util/makeBreakpointRegions.py"

# writing all output per sample to BPR/BAR.CTX-cluster.BPR.dat
# Define D as 5M; combine all breakpoints that are within D of each other along both chrom into one cluster
D=5000000
set +o posix

DATA_LIST="$BPS_DATA/A_Project/dat/1000SV.samples.dat"

# For each sample to process, loop over all unique (chromA, chromB) pairs
# Call makeBreakpointRegions.py on each such pair.
while read l; do  # iterate over all barcodes
# barcode	bam_path	CTX_path	Pindel_path
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    DAT="$BPS_DATA/B_CTX/dat/$BAR.CTX.BPC.dat"
    # chr1    125083149   chr7    58063127

    OUT="$OUTD/${BAR}.CTX-cluster.BPR.dat"
    rm -f $OUT
    HEADER="-H"

    # Iterate over all unique chromA, chromB pairs in each sample
    while read m; do
        CHROMA=`echo $m | awk '{print $1}'`
        CHROMB=`echo $m | awk '{print $2}'`

        python $BIN $HEADER -c -A $CHROMA -B $CHROMB -R $D $DAT stdout >> $OUT
        HEADER=""
    done < <(cut -f 1,3 $DAT | sort -u)  # this selects all unique chromA, chromB pairs and loops over them
    # barcode bam_path    CTX_path

    echo Written to $OUT

done < $DATA_LIST  # iterate over all barcodes
