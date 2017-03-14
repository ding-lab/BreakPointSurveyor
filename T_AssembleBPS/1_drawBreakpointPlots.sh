# Combine GGP panels and draw a Breakpoint Surveyor PDF figure for each line in PlotList
source ./AssembleBPS.config

DATD="$BPS_DATA/K_ReadDepth/dat"

BPD="$BPS_DATA/N_DrawBreakpoint/dat/GGP"
DEPD="$BPS_DATA/O_DrawDepth/dat/GGP"
ANND="$BPS_DATA/P_DrawAnnotation/dat/GGP"
HISTD="$BPS_DATA/Q_DrawHistogram/dat/GGP"

FLANKN="50K"
PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.50K.dat"

BIN="$BPS_CORE/src/plot/BreakpointSurveyAssembler.R"

# Usage: process_plot NAME 
function process_plot {
    BREAKPOINTS="$BPD/$BAR/${NAME}.Breakpoints.ggp"
    A_DEPTH="$DEPD/$BAR/${NAME}.A.${FLANKN}.depth.ggp"
    B_DEPTH="$DEPD/$BAR/${NAME}.B.${FLANKN}.depth.ggp"
    HISTOGRAM="$HISTD/$BAR/${NAME}.${FLANKN}.histogram.ggp"

    # chrom annotation may not exist in cases where no gene features in region of interest.  Handle this gracefully.
    ANNOTATION_A="$ANND/$BAR/${NAME}.chrom.A.annotation.ggp"
    ANNOTATION_B="$ANND/$BAR/${NAME}.chrom.B.annotation.ggp"

    if [ -f $ANNOTATION_A ]; then
        AA="-a $ANNOTATION_A"
    fi
    if [ -f $ANNOTATION_B ]; then
        AB="-A $ANNOTATION_B"
    fi

    # OUTDD="$OUTD/$BAR"  # this is good if lots of output, not necessary for Lite
    OUTDD="$OUTD"
    mkdir -p $OUTDD
    OUT="$OUTDD/${NAME}.BreakpointSurvey.pdf"

    TITLE="$BAR Breakpoint Surveyor Structure Plot"

    ARGS="-c $A_CHROM -C $B_CHROM"
    Rscript $BIN $MARKS -P $AA $AB -t "$TITLE" -H $HISTOGRAM $ARGS $BREAKPOINTS $A_DEPTH $B_DEPTH $OUT

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
done < $PLOT_LIST



