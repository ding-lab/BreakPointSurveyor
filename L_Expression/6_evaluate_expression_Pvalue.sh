# Calcuate p-values representing degree of over/under-expression of 
# case relative to controls.  See notes in ExonExpressionAnalyzer.R
#
# TODO: Describe algorithm 

# Support provided for cluster queuing system (bsub)
# Turn queuing on/off with USE_BSUB=1/0
USE_BSUB=1


source ./Expression.config

PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.50K.dat"
BIN="$BPS_CORE/src/analysis/ExonExpressionAnalyzer.R"

EXOND="$OUTD/BED"
RPKMD="$OUTD"
OUTDD="$OUTD/FDR"
mkdir -p $OUTDD

if [ $USE_BSUB == 1 ]; then
    # using bsub
    mkdir -p bsub
fi

# per-sample Pvalues (indicating up or downregulation after integration event) written to per-gene file
# per-exon Pvalues written to OUTEXON file below

function process {
    NAME=$1
    CHROM_ID=$2     # A or B
    BAR=$3
    DIS=$4

    SAM=`echo $BAR | cut -c 1-15`
    EXONS="$EXOND/${NAME}.${CHROM_ID}.neighbor.exon.bed"
    RPKM="$RPKMD/${DIS}_RPKM.dat" # real dataset

    # Trial run with full BA-4077 dataset with -A 100K took 5m4.059s.
    ARGS="-n $NAME -A 100000 -F" 

    if [ ! -f $EXONS ]; then
        echo $EXONS does not exist.  Skipping analysis.
        continue
    fi

    OUTGENE="$OUTDD/${NAME}.gene.pval.FDR.dat"
    echo Processing $NAME

    CMD="Rscript $BIN $ARGS -s $OUTGENE $SAM $RPKM $EXONS"

    if [ $USE_BSUB == 0 ]; then
        echo Executing: $CMD
        $CMD
    else
        bsub -oo bsub/$NAME.6.bsub $CMD   
    fi
}

while read l
do
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    # extract sample names
    NAME=`echo "$l" | cut -f 2`     # NAME is unique per integration event and should be used for all filenames
    BAR=`echo "$l" | cut -f 1`
    DIS=`grep $BAR $SAMPLE_LIST | cut -f 2`

    # focus on human chrom for now
    if [ $FLIPAB == 1 ]; then       # defined in ../bps.config
        process $NAME B $BAR $DIS
    else
        process $NAME A $BAR $DIS
    fi

done < $PLOT_LIST
