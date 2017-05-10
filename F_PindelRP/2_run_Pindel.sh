# Start Pindel runs

source ./BPS_Stage.config

# This BED file lists just the virus genomes
# This makes Pindel faster by focusing only on virus/virus and virus/human breakpoints
BED="$BPS_DATA/A_Reference/dat/GRCh37_selectVirus_9a.bed"


function process {
    BAR=$1
    BAM=$2
    REF=$3

    CFG="$OUTD/config/${BAR}.cfg"
    POUT="$OUTD/$BAR"

    # -I allows interchromosomal event detection
    JBED="-j $BED -I "
    SHCMD="$PINDEL -f $REF -i $CFG $JBED -o $POUT"

    $SHCMD
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
