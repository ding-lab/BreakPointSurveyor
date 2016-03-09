# create chrom annotation GGP file for every row in PlotList.dat
DATD="../A_Data/origdata"
PLOT_LIST="$DATD/PlotList.BPS.50K.dat"
#PLOT_LIST="test.PlotList.BPS.50K.dat"
BIN="/Users/mwyczalk/Data/TCGA_SARC/ICGC/BreakpointSurveyor/G_Annotation/src/AnnotationCruncher.R"

OUTD="GGP"
mkdir -p $OUTD

GENES="$DATD/genes.ens75.bed"
EXONS="$DATD/exons.ens75.bed"

FLANK="50K"

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

#Chrom A
NAME=`echo "$l" | cut -f 2`     
BAR=`echo "$l" | cut -f 1`
CHR=`echo "$l" | cut -f 3`
START=`echo "$l" | cut -f 6`
END=`echo "$l" | cut -f 7`

OUT="$OUTD/${NAME}.chrom.A.annotation.ggp"
ARGS=" $E -a $START -b $END -c $CHR"
Rscript $BIN $ARGS -e $EXONS $GENES $OUT

# Chrom B
CHR=`echo "$l" | cut -f 8`
START=`echo "$l" | cut -f 11`
END=`echo "$l" | cut -f 12`

OUT="$OUTD/${NAME}.chrom.B.annotation.ggp"
ARGS=" $E -a $START -b $END -c $CHR"
Rscript $BIN  -B $ARGS -e $EXONS $GENES $OUT
exit

done < $PLOT_LIST

