# create two gene annotation GGP files for every row in PlotList.dat
# Using annotation from Ensembl 84, for GRCh38

source ./DrawAnnotation.config

FLANKN="50K"

DATD="$BPS_DATA/K_ReadDepth/dat"
PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.50K.dat"
BIN="$BPS_CORE/src/plot/AnnotationDrawer.R"

OUTDD="$OUTD/GGP"
mkdir -p $OUTDD

AD="$BPS_DATA/B_ExonGene/dat"
GENES="$AD/genes.ens84.norm.bed"
EXONS="$AD/exons.ens84.norm.bed"

# usage: process_chrom A
function process_chrom {
    CHR=$1
    START=$2
    END=$3
    CHROM_ID=$4
    FLAG=$5

    OUT="$OUTDDD/${NAME}.chrom.${CHROM_ID}.annotation.ggp"
    ARGS=" $FLAG -A $CHR:$START-$END"
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
    OUTDDD="$OUTDD/$BAR"
    mkdir -p $OUTDDD

    # Chrom A
    CHR_A=`echo "$l" | cut -f 3`
    START_A=`echo "$l" | cut -f 6`
    END_A=`echo "$l" | cut -f 7`

    # Chrom B
    CHR_B=`echo "$l" | cut -f 8`
    START_B=`echo "$l" | cut -f 11`
    END_B=`echo "$l" | cut -f 12`

    process_chrom $CHR_A $START_A $END_A A 
    process_chrom $CHR_B $START_B $END_B B "-B"

done < $PLOT_LIST

