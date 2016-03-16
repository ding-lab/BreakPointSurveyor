# Create CTX Breakpoint Coordinate GGP files

DATD_CTX="../B_CTX/dat"
DATD_PL="../G_PlotList/dat"
PLOT_LIST="$DATD_PL/TCGA_SARC.PlotList.50K.dat"

BIN="/Users/mwyczalk/Data/BreakpointSurveyor/BreakpointSurveyor/src/plot/BreakpointDrawer.R"

OUTD="GGP"
mkdir -p $OUTD

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
    BPC="$DATD_CTX/${BAR}.CTX.BPC.dat"

    OUTDD="$OUTD/$BAR"
    mkdir -p $OUTDD
    OUT="$OUTDD/${NAME}.Breakpoints.CTX.ggp"  

# Usage: Rscript BreakpointDrawer.R [-v] [-P] [-A range.A] [-B range.B] [-F] [-G fn.ggp] [-p plot.type] 
#                [-a alpha][-c color][-f fill][-s shape][-z size] BP.fn breakpoint.ggp
# default CTX values: geom_point.  color="#377EB8", alpha = 0.5
    RANGE_A="-A ${A_CHROM}:${A_START}-${A_END}" 
    RANGE_B="-B ${B_CHROM}:${B_START}-${B_END}" 
    ARGS=" -a 1.0 "
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

