# Create Breakpoint Coordinates GGP file for each PlotList line with PindelRP regions drawn
source ./BPS_Stage.config

DATD="$BPS_DATA/F_PindelRP/dat"
BIN="$BPS_CORE/src/plot/BreakpointDrawer.R"

OUTDD="$OUTD/GGP.PindelRP"
mkdir -p $OUTDD

rm -f $OUTD/GGP  # GGP is a link
ln -s ../$OUTDD $OUTD/GGP

# Usage: process_plot BAR NAME A_CHROM A_START A_END B_CHROM B_START B_END 
function process_plot {
    BAR=$1
    NAME=$2
    A_CHROM=$3
    A_START=$4
    A_END=$5
    B_CHROM=$6
    B_START=$7
    B_END=$8

    # Breakpoint coordinate file
    BPC="$DATD/BPR/${BAR}.PindelRP.BPR.dat"

    OUTDDD="$OUTDD/$BAR"
    mkdir -p $OUTDDD
    OUT="$OUTDDD/${NAME}.Breakpoints.ggp"  

    #ARGS=" -a 0.5 -c gray50 -f gray50 -z 0 -p region"
    ARGS=" -a 0.5 -c NA -f gray50 -z 0 -p region"

    RANGE_A="-A ${A_CHROM}:${A_START}-${A_END}" 
    RANGE_B="-B ${B_CHROM}:${B_START}-${B_END}" 
    if [ $FLIPAB == 1 ]; then       # defined in ../bps.config
        ARGS="$ARGS -l"
    fi
    Rscript $BIN $RANGE_A $RANGE_B $ARGS $BPC $OUT
}

while read l
do

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

process_plot $BAR $NAME $A_CHROM $A_START $A_END $B_CHROM $B_START $B_END 

done < $PLOT_LIST

