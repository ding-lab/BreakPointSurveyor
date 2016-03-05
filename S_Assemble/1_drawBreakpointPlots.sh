# Combines GGP data for all integration events and writes a Breakpoint Surveyor PDF figure.
DISD="../E_Breakpoint/GGP"
DEPD="../F_ReadDepth/GGP"
ANND="../G_Annotation/GGP"

PLOT_LIST="../A_Data/origdata/PlotList.BPS.50K.dat"

BIN="/Users/mwyczalk/Data/TCGA_SARC/ICGC/BreakpointSurveyor/S_Draw/src/BreakpointDrawer.R"

OUTD="plots"
mkdir -p $OUTD

# Usage: process_plot NAME
function process_plot {
    BREAKPOINTS="$DISD/${NAME}.breakpoints.ggp"
#TCGA-DX-A1KW-01A-22D-A24N-09.AA.chr_1_10.A.DEPTH.ggp
    A_DEPTH="$DEPD/${NAME}.A.DEPTH.ggp"
    B_DEPTH="$DEPD/${NAME}.B.DEPTH.ggp"
    # HISTOGRAM="$DEPD/${NAME}.histogram.ggp"

    # chrom annotation may not exist in cases where no gene features in region of interest.  Handle this gracefully.
    ANNOTATION_A="$ANND/${NAME}.chrom.A.annotation.ggp"
    ANNOTATION_B="$ANND/${NAME}.chrom.B.annotation.ggp"
    if [ -f $ANNOTATION_A ]; then
        AA="-a $ANNOTATION_A"
    fi
    if [ -f $ANNOTATION_B ]; then
        AB="-A $ANNOTATION_B"
    fi

    OUT="$OUTD/${NAME}.BreakpointSurvey.pdf"

    #TITLE=`echo $BAR | cut -c 6-15`
    #TITLE="${NAME} (${DIS})"

    #ARGS="$CA -A $VIRUS_ANNOTATION"

    #Rscript src/BreakpointDrawer.R -t "$TITLE" -H $HISTOGRAM $ARGS $DISCORDANT $CHROM_DEPTH $VIRUS_DEPTH $OUT

    Rscript $BIN $AA $AB -t "$NAME" $ARGS $BREAKPOINTS $A_DEPTH $B_DEPTH $OUT

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

process_plot $NAME
exit

done < $PLOT_LIST



