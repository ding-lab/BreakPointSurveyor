# create two annotation GGP files for every row in PlotList.dat
FLANKN="50K"
DATD="../B_PlotList/dat"
PLOT_LIST="../B_PlotList/dat/Combined.PlotList.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/BreakpointSurveyor/BreakpointSurveyor/src/plot/AnnotationRenderer.R"

OUTD="GGP"
mkdir -p $OUTD

AD="../D_Annotation/dat"
GENES="$AD/genes.ens75.bed"
EXONS="$AD/exons.ens75.bed"

# usage: process_chrom A
function process_chrom {
    CHROM_ID=$1
    FLAG=$2

    OUT="$OUTDD/${NAME}.chrom.${CHROM_ID}.annotation.ggp"
    ARGS="$FLAG -A $CHR:$START-$END"
    Rscript $BIN $ARGS -e $EXONS $GENES $OUT
}

while read l
do
#     1  barcode TCGA-DX-A1KW-01A-22D-A24N-09
#     2  name    TCGA-DX-A1KW-01A-22D-A24N-09.AA.chr_1_10
#     3  chrom.A 1
#     4  event.A.start   33108583
#     5  event.A.end 33108583
#     6  range.A.start   33058583
#     7  range.A.end 33158583
#     8  chrom.B 10
#     9  event.B.start   120854757
#    10  event.B.end 120854757
#    11  range.B.start   120804757
#    12  range.B.end 120904757
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue


NAME=`echo "$l" | cut -f 2`     
BAR=`echo "$l" | cut -f 1`
OUTDD="$OUTD/$BAR"
mkdir -p $OUTDD

# Chrom A
CHR=`echo "$l" | cut -f 3`
START=`echo "$l" | cut -f 6`
END=`echo "$l" | cut -f 7`
process_chrom A 

# Chrom B
CHR=`echo "$l" | cut -f 8`
START=`echo "$l" | cut -f 11`
END=`echo "$l" | cut -f 12`

process_chrom B "-B"
exit

done < $PLOT_LIST

