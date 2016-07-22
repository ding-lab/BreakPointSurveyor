# Combine GGP panels and draw a Breakpoint Surveyor PDF figure for each line in PlotList
BPD="../N_RenderBreakpoint/GGP"
DEPD="../O_RenderDepth/GGP"
ANND="../P_RenderAnnotation/GGP"
HISTD="../Q_RenderHistogram/GGP"

FLANKN="50K"

DATD_PL="../G_PlotList/dat"
PLOT_LIST="$DATD_PL/TCGA_Virus.PlotList.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/BreakpointSurveyor/BreakpointSurveyor/src/plot/BreakpointSurveyAssembler.R"

OUTD="plots"
mkdir -p $OUTD

# Usage: process_plot NAME 
function process_plot {
    BREAKPOINTS="$BPD/$BAR/${NAME}.Breakpoints.CTX.ggp"
#TCGA-DX-A1KW-01A-22D-A24N-09.AA.chr_1_10.A.DEPTH.ggp
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

    OUTDD="$OUTD/$BAR"
    mkdir -p $OUTDD
    OUT="$OUTDD/${NAME}.BreakpointSurvey.pdf"

    #MARKS="-N -d 33075000,33100000,33145000 -D 120820000,120880000,120895000"
    ARGS="-c $A_CHROM -C $B_CHROM"
    TITLE="$BAR Interchromosomal Translocation"

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



