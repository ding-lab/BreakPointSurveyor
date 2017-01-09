# Create Breakpoint Coordinates GGP file for each PlotList line with PindelRP regions drawn
source ./DrawBreakpoint.config

PLOT_LIST="$BPS_DATA/G_PlotList/dat/TCGA_Virus.PlotList.50K.dat"
DATD="$BPS_DATA/C_PindelRP/dat"
BIN="$BPS_CORE/src/plot/BreakpointDrawer.R"

OUTDD="$OUTD/GGP.PindelRP"
mkdir -p $OUTDD

rm -f $OUTD/GGP  # GGP is a link
ln -s $OUTDD $OUTD/GGP

# In the assembled plot, chrom positions A and B correspond to x, y coordinates, respectively.
# By default, chrom A < chrom B (by string comparison), as in BPC/BPR files.
# This order can be switched by setting FLIPAB=1 (by default, FLIPAB=0)
# Note that this option will need to be defined consistently in any steps which process BPC/BPR files
FLIPAB=1

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

    ARGS=" -a 0.5 -c gray50 -f gray50 -z 0 -p region"

    RANGE_A="-A ${A_CHROM}:${A_START}-${A_END}" 
    RANGE_B="-B ${B_CHROM}:${B_START}-${B_END}" 
    if [ $FLIPAB == 1 ]; then
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

