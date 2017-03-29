# Create visual representation of per-gene Pval data 
# Breakpoint positions given by Chrom A
source ./BPS_Stage.config

# ImageMagick https://www.imagemagick.org/script/download.php
BIN="convert"


function process {
    DAT=$1
    OUT=$2
    $BIN -flatten -density 300 -resize 50% $DAT $OUT

    echo Written to $OUT

}

PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.50K.dat"
while read L; do

    # Skip comments and header
    [[ $L = \#* ]] && continue
    [[ $L = barcode* ]] && continue


    BAR=`echo $L | awk '{print $1}'`
    NAM=`echo $L | awk '{print $2}'`

    DAT="$OUTD/${NAM}.FDR.bubble.pdf"
    OUT="$OUTD/${NAM}.FDR.bubble.png"

    process $DAT $OUT

done < $PLOT_LIST

