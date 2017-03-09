# Normalize SBP for downstream analysis.  
# Note that assuming virus breakpoint
# old name rSBP = new name BPC

source ./Contig.config

LIST="$BPS_DATA/A_Project/dat/samples.dat"
BIN="$BPS_CORE/src/contig/SBPprocessor.R"

DATD="$OUTD/SBP" 
OUTDD="$OUTD/BPC"  
mkdir -p $OUTDD

function process {
    BAR=$1

    DAT="$DATD/${BAR}.SBP.dat" 
    ROUT="$OUTDD/${BAR}.BPC.dat"
    QOUT="$OUTDD/${BAR}.qSBP.dat"

    if [ ! -e $DAT ]; then
        echo $DAT does not exist.  
        continue
    fi

    Rscript $BIN -o $ROUT -q $QOUT $DAT
}

while read l; do  # iterate over all rows of samples.dat

    # Skip comments and header
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`

    process $BAR

done < $LIST
