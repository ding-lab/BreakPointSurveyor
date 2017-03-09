# See README for details of processing here.
# From, /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/UnifiedVirus2/U_SAMBreakpoints/3_make_SBP.sh

source ./Contig.config

LIST="$BPS_DATA/A_Project/dat/samples.dat"
BIN="$BPS_CORE/src/contig/BreakPointParser.R"

DATD="$OUTD/pSBP" 
OUTDD="$OUTD/SBP"  # keep this as SBP.  Move QMD5 to "SAM"
mkdir -p $OUTDD

function process {
    BAR=$1

    DAT="$DATD/${BAR}.pSBP.dat"
    OUT="$OUTDD/${BAR}.SBP.dat"

    Rscript $BIN -o $OUT $DAT
    echo Written to $OUT
}

while read l; do  # iterate over all rows of samples.dat

    # Skip comments and header
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`

    process $BAR

done < $LIST
