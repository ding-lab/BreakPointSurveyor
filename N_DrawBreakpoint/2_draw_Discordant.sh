# Append CTX data to Breakpoint Coordinates GGP files
source ./DrawBreakpoint.config

PLOT_LIST="$BPS_DATA/G_PlotList/dat/TCGA_Virus.PlotList.50K.dat"
DATD="$BPS_DATA/D_Discordant/dat/BPC"
BIN="$BPS_CORE/src/plot/BreakpointDrawer.R"

INDD="$OUTD/GGP.PindelRP"
OUTDD="$OUTD/GGP.Discordant"
mkdir -p $OUTDD

rm -f $OUTD/GGP  # GGP is a link
ln -s $OUTDD $OUTD/GGP

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
    BPC="$DATD/${BAR}.Discordant.BPC.dat"

    OUTDDD="$OUTDD/$BAR"
    mkdir -p $OUTDDD
    # removing step name from output filename so can access it uniformly down the road
    IN="$OUTD/GGP.PindelRP/$BAR/${NAME}.Breakpoints.ggp"  
    OUT="$OUTDDD/${NAME}.Breakpoints.ggp"  

    RANGE_A="-A ${A_CHROM}:${A_START}-${A_END}" 
    RANGE_B="-B ${B_CHROM}:${B_START}-${B_END}" 
    ARGS=" -p point -a 1.0 -G $IN"
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

