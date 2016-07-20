# Normalize SBP for downstream analysis.  
# From, /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/UnifiedVirus2/U_SAMBreakpoints/4_make_rSBP.sh
# Note that assuming virus breakpoint

UTD="rSBP"

source ./Contig.config

LIST="$BPS_DATA/A_Project/dat/TCGA_Virus.samples.dat"
BIN="$BPS_CORE/src/contig/SBPprocessor.R"

DATD="$OUTD/SBP" 
OUTDD="$OUTD/rSBP"  
mkdir -p $OUTDD

function process {
    BAR=$1

    DAT="$DATD/${BAR}.SBP.dat" 
    ROUT="$OUTDD/${BAR}.rSBP.dat"
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
