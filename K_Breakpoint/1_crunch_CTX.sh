# Creates a series of CTX Breakpoint Coordinate GGP files

# that are used for creating the combined plot.  
# No plotting takes place here.

# create discordant.ggp for every row in PlotList.dat
DATD="../A_Data/origdata"
FLANKN="50K"
PLOT_LIST="$DATD/PlotList.BPS.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/TCGA_SARC/ICGC/BreakpointSurveyor/E_Breakpoint/src/BreakpointCruncher.R"

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
    BPC="$DATD/BP/${BAR}.BPC.dat"

#    PIN="../A_Data/origdata/RP/${BAR}_RP"   
#    RSBPFN="$SBPD/${BAR}.rSBP.dat"
#    QSBPFN="$SBPD/${BAR}.qSBP.dat"
#    if [ -e $RSBPFN ]; then
#        RSBP="-r $RSBPFN"
#    fi

    # for now not plotting QSBP, which connects breakpoints on same contig
    #if [ -e $QSBPFN ]; then
    #    QSBP="-q $QSBPFN"
    #fi

    OUT="$OUTD/${NAME}.Breakpoints.CTX.ggp"
    OUT="$OUTD/${NAME}.Breakpoints.CTX.pdf"  # testing

# Usage: Rscript BreakpointCruncher.R [-v] [-A range.A] [-B range.B] [-F] [-g fn.ggp] [-p plot.type] 
#                [-a alpha][-c color][-f fill][-s shape][-z size] BP.fn breakpoint.ggp
# default CTX values: geom_point.  color="#377EB8", alpha = 0.5
    RANGE_A="-A ${A_CHROM}:${A_START}-${A_END}" 
    RANGE_B="-B ${B_CHROM}:${B_START}-${B_END}" 
    ARGS=" -a 1.0 -P"
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
exit

done < $PLOT_LIST

