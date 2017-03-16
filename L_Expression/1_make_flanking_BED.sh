# Create BED files based on PlotList regions with given "flank", or padding around integration event.
# This region is independent of the "50K" region in PlotList, and is used to identify genes whose expression
# will be evaluated.
# One BED file is created for every integration event on human chrom.  
# writes e.g., $DAT/BED/TCGA-BA-4077-01B-01D-2268-08.AA.chr14.A.1M.bed

source ./Expression.config

PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.50K.dat"

EXONS="$BPS_DATA/B_ExonGene/dat/exons.ens75.bed"
GENES="$BPS_DATA/B_ExonGene/dat/genes.ens75.bed"

FLANK="1000000"  # distance around each integration region to be included in BED file
FLANKN="1M"

OUTDD="$OUTD/BED"
mkdir -p $OUTDD

#1) use bedtools slop + intersect to get list of genes within region of interest
#2) grep exon list for these gene names to get all exons for these genes
function process {
    NAME=$1
    CHROM_ID=$2  # A or B
    CHR=$3
    START=$4
    END=$5
    FAI=$6

    OUT="$OUTDD/${NAME}.${CHROM_ID}.${FLANKN}.bed"

    # Bedtools slop expands range of each breakpoint.  This creates the region of interest
    # bedtools intersect with genes gives list of genes in region of interest
    # we extract genes and use that as input into grep of all exons
    echo -e "$CHR\t$START\t$END" | bedtools slop -g $FAI -i stdin -b $FLANK | bedtools intersect -a $GENES -b stdin | cut -f 4 | fgrep -w -f - $EXONS | bedtools sort -i stdin > $OUT
    echo Written to $OUT
}


while read l; do
# barcode name    chrom.A event.A.start   event.A.end range.A.start   range.A.end chrom.B event.B.start   event.B.end range.B.start   range.B.end
# TCGA-IS-A3KA-01A-11D-A21Q-09    TCGA-IS-A3KA-01A-11D-A21Q-09.chr_1_2.aa 1   5156542 207193935   5106542 207243935   2   122476446   228566993   122426446   228616993

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

    # extract sample names
    BAR=`echo "$l" | cut -f 1`
    NAME=`echo "$l" | cut -f 2`

    A_CHROM=`echo "$l" | cut -f 3`
    A_START=`echo "$l" | cut -f 4`
    A_END=`echo "$l" | cut -f 5`

    B_CHROM=`echo "$l" | cut -f 8`
    B_START=`echo "$l" | cut -f 9`
    B_END=`echo "$l" | cut -f 10`

    # barcode   disease BAM_path    ref_path
    REF=`grep $BAR $SAMPLE_LIST | cut -f 4`
    FAI="$REF.fai"

    # usage: process NAME CHROM_ID CHR START END FAI
    # Processing only human, which is typically chrom A of an integration event (B if FLIPAB=1)
    # To incude virus, need to add virus genes and exons to B_ExonGene/dat/genes.ens75.bed, exons.ens75.bed

    if [ $FLIPAB == 1 ]; then  # see ../bps.config
        process $NAME B $B_CHROM $B_START $B_END $FAI
    else
        process $NAME A $A_CHROM $A_START $A_END $FAI
    fi

done < $PLOT_LIST
