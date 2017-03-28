# Append contig data to Breakpoint Coordinates GGP files
source ./DrawBreakpoint.config

PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.50K.dat"
DATD="$BPS_DATA/I_Contig/dat/BPC"
BIN="$BPS_CORE/src/plot/BreakpointDrawer.R"

INDD="$OUTD/GGP.Discordant"
OUTDD="$OUTD/GGP.Contig"
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
    BPC="$DATD/${BAR}.BPC.dat"

    OUTDDD="$OUTDD/$BAR"
    mkdir -p $OUTDDD
    IN="$INDD/$BAR/${NAME}.Breakpoints.ggp"  
    OUT="$OUTDDD/${NAME}.Breakpoints.ggp"  

    # If data file does not exist, simply copy IN to OUT (so it exists for downstream processing) and continue
    if [ ! -f $BPC ]; then
        echo "$BPC does not exist - skipping..."
        cp -f $IN $OUT
        return
    fi

    RANGE_A="-A ${A_CHROM}:${A_START}-${A_END}" 
    RANGE_B="-B ${B_CHROM}:${B_START}-${B_END}" 

    # Define how the point looks here:
    #   See [BreakpointSurveyor-Core]/src/plot/BreakpointDrawer.R for details
    # -a: transparency (0-1)
    # -s: shape - see http://www.cookbook-r.com/Graphs/Shapes_and_line_types/
    # -z: size
    # -c: color
    ARGS=" -p point -a 0.75 -s 3 -z 4 -c #4DAF4A "
    if [ $FLIPAB == 1 ]; then   # defined in ../bps.config
        ARGS="$ARGS -l"
    fi

    Rscript $BIN $RANGE_A $RANGE_B $ARGS -G $IN $BPC $OUT
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

