# Create visual representation of per-gene Pval data 
# Breakpoint positions given by Chrom A
source ./RPKMBubble.config
DATD="$BPS_DATA/L_Expression/dat"

BIN="$BPS_CORE/src/plot/PvalBubblePlotter.R"

FLANK="1000000"

# We plot either panel A or B by choosing PLOTA=0 or 1, resp.
PLOTA=1

PLOT_LIST="$BPS_DATA/J_PlotList/dat/TCGA_Virus.PlotList.50K.dat"
while read L; do

# barcode name    chrom.A event.A.start   event.A.end range.A.start   range.A.end chrom.B event.B.start   event.B.end range.B.start   range.B.end

# Skip comments and header
[[ $L = \#* ]] && continue
[[ $L = barcode* ]] && continue


BAR=`echo $L | awk '{print $1}'`
NAM=`echo $L | awk '{print $2}'`
if [ $PLOTA == 0 ]; then    
    CHR=`echo $L | awk '{print $3}'`
    START=`echo $L | awk '{print $4}'`
    END=`echo $L | awk '{print $5}'`
else
    CHR=`echo $L | awk '{print $8}'`
    START=`echo $L | awk '{print $9}'`
    END=`echo $L | awk '{print $10}'`
fi

SAM=`echo $BAR | cut -c 1-15` # TCGA Sample Name, E.g., TCGA-BA-4077

SHORT_NAM=`echo $BAR | cut -f 2-3 -d-`  # TCGA "Short Name", e.g., BA-4077

OUT="$OUTD/${NAM}.FDR.bubble.pdf"
DAT="$DATD/FDR/${NAM}.gene.pval.FDR.dat"

if [ ! -f $DAT ]; then
    echo $DAT does not exist.  Skipping plotting.
    continue
fi

XLAB="$SHORT_NAM Chrom $CHR Position"
PVAL="0.05" # Show bubble guide mark

echo $NAM
# -F plots FDR
ARGS="\
-h 2 -w 10 \
-l -F \
-a $START \
-b $END \
-f $FLANK \
-s $SAM \
-p $PVAL "

Rscript $BIN $ARGS $DAT $OUT
done < $PLOT_LIST

