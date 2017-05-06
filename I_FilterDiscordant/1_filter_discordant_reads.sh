# Filter discordant reads to retain only those which fall into top prioritized clusters

source ./BPS_Stage.config

BPR="../H_PlotList/dat/BPC/NA19240.Discordant-prioritized.BPR.dat"
DATD="../G_Discordant/dat.untracked"

U_OUTD="dat.untracked"
mkdir -p $U_OUTD

FILTER="$BPS_CORE/src/util/SAMFilter.py"

function process {
    BAR=$1
    BAM=$2

    DAT="$DATD/discordant_$BAR.sam"

    OUT="$U_OUTD/filtered_discordant_$BAR.sam"

    python $FILTER -p 100 -i $DAT -o $OUT $BPR
    echo Written to $OUT
}

while read l
do
    # Skip comments and header
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    BAM=`echo $l | awk '{print $3}'`

    process $BAR $BAM
done < $SAMPLE_LIST

