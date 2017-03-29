# Create Pindel configuration files which give the BAM path

source ./BPS_Stage.config

OUTDD="$OUTD/config" 
mkdir -p $OUTDD

# Generate Pindel configuration file
function process {
    BAR=$1
    BAM=$2
    REF=$3

    OUT="$OUTDD/${BAR}.cfg"

    echo -e  "${BAM}\t500\t${BAR}" > $OUT
    echo Written to $OUT
}

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
