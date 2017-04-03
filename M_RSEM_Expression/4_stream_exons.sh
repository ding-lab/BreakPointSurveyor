# add stream information (whether upstram, downstream, or intra) to each exon BED file generated in step 1
# Doing only Chrom A (human in human/virus bp, unless FLIPAB=1)

# during processing the ExonPicker.R script prints out stats about whether integration event is
# intronic or exonic, like,
#   integration event 68683065 - 68742035
#   Genes with exon in integration event:
#   Genes with intronic integration event: RAD51B
# this is saved to NeighborSummary.dat for later processing.

# Writes e.g., $DAT/BED/TCGA-BA-4077-01B-01D-2268-08.AA.chr14.A.neighbor.exon.bed
# 14	67656109	67656286	FAM71D	upstream	+

source ./BPS_Stage.config
BEDD="$OUTD/BED"
BIN="$BPS_CORE/src/analysis/ExonPicker.R"

function process {
    NAME=$1
    CHROM_ID=$2  # A or B
    CHR=$3
    START=$4
    END=$5

    EXONS="$BEDD/${NAME}.${CHROM_ID}.exons.bed"
    OUT="$BEDD/${NAME}.${CHROM_ID}.exons.stream.bed"
    if [ ! -s $EXONS ]; then
        echo File $EXONS is empty.  Skipping.
        echo $NAME has no exons.  Skipping. >> $SUMMARY
        continue
    fi

    echo Processing $NAME
    ###
    # Rscript ExonPicker.R [-v] [-K num.genes] [-E] -a ie.start -b ie.end -c ie.chrom -e exons.bed -o out.dat
    ###
    ARGS=" -a $START -b $END -c $CHR -e $EXONS -o $OUT "
    echo $NAME >> $SUMMARY
    Rscript $BIN $ARGS >> $SUMMARY
}

SUMMARY="$OUTD/NeighborSummary.dat"
rm -f $SUMMARY

while read l
do
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue
    #barcode name    chrom.A event.A.start   event.A.end range.A.start   range.A.end chrom.B event.B.start   event.B.end range.B.start   range.B.end
    NAME=`echo "$l" | cut -f 2`     

    CHR_A=`echo "$l" | cut -f 3`
    START_A=`echo "$l" | cut -f 4`
    END_A=`echo "$l" | cut -f 5`

    CHR_B=`echo "$l" | cut -f 8`
    START_B=`echo "$l" | cut -f 9`
    END_B=`echo "$l" | cut -f 10`

    if [ $FLIPAB == 1 ]; then  # see ../bps.config
        process $NAME B $CHR_B $START_B $END_B
    else
        process $NAME A $CHR_A $START_A $END_A
    fi

done < $PLOT_LIST

echo Summary saved to $SUMMARY
