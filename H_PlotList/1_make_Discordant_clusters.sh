# Cluster nearby discordant breakpoints
# This is a relatively slow step, about 12 hours for NA19240 discordant reads

# Create BPR file which has regions of clustered breakpoints.
# Such events are per unique chromA/chromB pair
# In makeBreakpointRegions.py we combine into one region all breakpoints on chrom A as well as those on chrom B
# which are within a distance D from each other along both chromosomes.

# Last column of resulting BPR file is number of breakpoints in cluster

source ./BPS_Stage.config

BIN="$BPS_CORE/src/util/makeBreakpointRegions.py"
echo $BIN

# writing all output per sample to BPC/BAR.Discordant-cluster.BPC.dat
# Define D as 50K; combine all breakpoints that are within D of each other along both chrom into one cluster
D=50000
set +o posix

# Not tracking all clusters because this is a large file.
U_OUTD="dat.untracked"
mkdir -p $U_OUTD

OUTDD="$U_OUTD/BPC"
mkdir -p $OUTDD

function process_BPC {
    BAR=$1

    # Making assumptions about where Discordant data live
    DAT="$BPS_DATA/G_Discordant/dat.untracked/BPC/$BAR.Discordant.BPC.dat"
    OUT="$OUTDD/${BAR}.Discordant-cluster.BPR.dat"
    rm -f $OUT
    HEADER="-H"

    # Iterate over all unique chromA, chromB pairs in each sample
    while read m; do
        CHROMA=`echo $m | awk '{print $1}'`
        CHROMB=`echo $m | awk '{print $2}'`

        python $BIN $HEADER -c -A $CHROMA -B $CHROMB -R $D $DAT stdout >> $OUT
        HEADER=""
    # NOTE: the line below selects chromA, B columns from $DAT.  Assumptions about BPC, BPR format are embedded.
    done < <(grep -v "^#" $DAT | cut -f 1,3 | sort -u)  # this selects all unique chromA, chromB pairs and loops over them

    echo Written to $OUT

}

# For each sample to process, loop over all unique (chromA, chromB) pairs
# Call makeBreakpointRegions.py on each such pair.
while read l; do  # iterate over all barcodes
# barcode	bam_path	CTX_path	Pindel_path
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    process_BPC $BAR

done < $SAMPLE_LIST
