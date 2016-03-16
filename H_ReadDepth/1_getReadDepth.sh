# Evaluating read depth with pysam-based depth calculations.
# For every line in PLOT_LIST, evaluate depth for range.A and range.B

BAMLIST="../A_DataPaths/dat/DDLS_WGS_tumor.dat"
PLOT_LIST="../B_PlotList/dat/Combined.PlotList.50K.dat"

# Reads BAM files, loops over PlotList
# Writes two depth files per PlotList entry to dat/BAR/*.50K.DEPTH.dat

mkdir -p DEPTH

# limit number of points to 1K or so per segment.
N="-N 1000"
BIN="/usr/bin/python2.7 ../../BreakpointSurveyor/src/analysis/depthFilter.py"

# usage: process_chrom CHROM_ID NAME BAM CHROM RANGE_START RANGE_END
# CHROM_ID is either A or B
function get_depth {
    CHROM_ID=$1
    NAME=$2
    BAM=$3
    CHROM=$4
    START=$5
    END=$6

    OUTD="DEPTH/$BAR"
    mkdir -p $OUTD
    OUT="$OUTD/${NAME}.${CHROM_ID}.50K.DEPTH.dat"

    ARGS=$N
    # -t is timing
    echo $NAME $CHROM $START $END
    $BIN $N -o $OUT $CHROM $START $END $BAM
}



while read l; do
# barcode name    chrom.A event.A.start   event.A.end range.A.start   range.A.end chrom.B event.B.start   event.B.end range.B.start   range.B.end
# TCGA-IS-A3KA-01A-11D-A21Q-09    TCGA-IS-A3KA-01A-11D-A21Q-09.chr_1_2.aa 1   5156542 207193935   5106542 207243935   2   122476446   228566993   122426446   228616993

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
NAME=`echo "$l" | cut -f 2`

A_CHROM=`echo "$l" | cut -f 3`
A_START=`echo "$l" | cut -f 6`
A_END=`echo "$l" | cut -f 7`

B_CHROM=`echo "$l" | cut -f 8`
B_START=`echo "$l" | cut -f 11`
B_END=`echo "$l" | cut -f 12`

BAM=`grep $BAR $BAMLIST | cut -f 2`

# usage: process_chrom CHROM_ID NAME BAM CHROM RANGE_START RANGE_END
get_depth A $NAME $BAM $A_CHROM $A_START $A_END
get_depth B $NAME $BAM $B_CHROM $B_START $B_END

done < $PLOT_LIST