# Start Pindel runs

source ./PindelRP.config

BED="$CWD/dat/selectedVirus_2013.10a.bed"
BIN='pindel'

# NOTE: if this is a 9a run, need to use 9a BAMs, otherwise Pindel seg faults
# this is not currently done.

function process {
    BAR=$1
    BAM=$2
    REF=$3

    CFG="$OUTD/config/${BAR}.cfg"
    POUT="$OUTD/$BAR"
    SHCMD="$BIN -f $REF -i $CFG -j $BED -o $POUT"

    echo $SHCMD
}


### 
while read l
do
    # Skip comments and header
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    BAM=`echo $l | awk '{print $3}'`
    REF=`echo $l | awk '{print $4}'`

    process $BAR $BAM $REF
done < $SAMPLE_LIST
