# Cluster nearby PindelRP breakpoint regions

# This workflow can also be done with BPC data (e.g., discordant read BPC)

# Since PindelRP has regions (BPR), consider midpoint of region as breakpoint coordinate.  
# Create BPR file which has regions of clustered breakpoints.
# Such events are per unique chromA/chromB pair
# In makeBreakpointRegions.py we combine into one region all breakpoints on chrom A as well as those on chrom B
# which are within a distance D from each other along both chromosomes.

# Last column of resulting BPR file is number of breakpoints in cluster

source ./PlotList.config

BIN="$BPS_CORE/src/util/makeBreakpointRegions.py"
echo $BIN

# writing all output per sample to BPR/BAR.CTX-cluster.BPR.dat
# Define D as 5M; combine all breakpoints that are within D of each other along both chrom into one cluster
D=5000000
set +o posix

LIST="$BPS_DATA/A_Project/dat/WGS.samples.dat"

OUTDD="$OUTD/BPR"
mkdir -p $OUTDD

function process_BPR {
    BAR=$1

    # Making assumptions about where Pindel data live
    DAT="$BPS_DATA/F_PindelRP/dat/BPR/$BAR.PindelRP.BPR.dat"
    OUT="$OUTDD/${BAR}.PindelRP-cluster.BPR.dat"
    rm -f $OUT
    HEADER="-H"

    # Pindel _RP format:
    # chrom.A pos.A.start pos.A.end   chrom.B pos.B.start pos.B.end   strand
    # chr1    27825414    27826540    chr15   77617773    77618899    A- B+

    # Iterate over all unique chromA, chromB pairs in each sample
    while read m; do
        CHROMA=`echo $m | awk '{print $1}'`
        CHROMB=`echo $m | awk '{print $2}'`

        python $BIN $HEADER -r -c -A $CHROMA -B $CHROMB -R $D $DAT stdout >> $OUT
        HEADER=""
    # NOTE: the line below selects chromA, B columns from $DAT.  Assumptions about BPC, BPR format are embedded.
    done < <(grep -v "^#" $DAT | cut -f 1,4 | sort -u)  # this selects all unique chromA, chromB pairs and loops over them

    echo Written to $OUT

}

# function process_BPC is unimplemented, but the key difference is that CHROMB comes from
# a different column:
    # ...
    # done < <(grep -v "^#" $DAT | cut -f 1,3 | sort -u)  
# Also, get rid of the -r when calling makeBreakpointRegions.py 
# c.f. /gscuser/mwyczalk/projects/1000SV/1000SV.Workflow/J_PlotList/1_make_CTX_clusters.sh


# For each sample to process, loop over all unique (chromA, chromB) pairs
# Call makeBreakpointRegions.py on each such pair.
while read l; do  # iterate over all barcodes
# barcode	bam_path	CTX_path	Pindel_path
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    process_BPR $BAR

done < $LIST  # iterate over all barcodes
