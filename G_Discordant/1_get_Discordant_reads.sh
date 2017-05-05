# Extract all discordant reads (those for whom RNEXT != "=")
# with mapping quality > 25

# Support provided for cluster queuing system (bsub)
# - Creates a processing script $BSUBNAM, which can be executed locally or on cluster
# - this is also useful if you want to generate script to run prior to executing it
# Turn on queuing by setting USE_BSUB=1
USE_BSUB=0

MAPQ=25	# Reads with quality < MAPQ are discarded

# We are not tracking this data due to size
U_OUTD="dat.untracked"
mkdir -p $U_OUTD

source ./BPS_Stage.config

if [ $USE_BSUB == 1 ]; then    
    # using bsub
    mkdir -p bsub
    BSUBNAM="run_all_bsub.sh"
    rm -f $BSUBNAM
    echo "# This file created automatically by $0" >  $BSUBNAM
fi  

function process {
    BAR=$1
    BAM=$2

    # process BAM to get just the discordant reads (written to DOUT)
    DOUT="$U_OUTD/discordant_$BAR.sam"

    # SAM specs: https://samtools.github.io/hts-specs/SAMv1.pdf
    # col 5 is MAPQ of read
    # col 7 is RNEXT.  If RNEXT is "=", it is the same as mate, and is not discordant by our definition

    # keeping just high quality discordant reads

    echo Processing $BAR

    SHCMD1="samtools view  $BAM | awk -v mapq=$MAPQ 'BEGIN{FS=\"\t\"} {if ((\$7 !~ /=/) && (\$5 >= mapq))  print}' > $DOUT"

    if [ $USE_BSUB == 1 ]; then
        SHNAM="bsub/run_$BAR.sh"
        echo $SHCMD1 >  $SHNAM

        echo "bsub -o bsub/$BAR.out -e bsub/$BAR.err sh $SHNAM" >> $BSUBNAM
    else
        echo $SHCMD1 | sh
        echo Written to $DOUT
    fi
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


if [ $USE_BSUB == 1 ]; then
    echo Written to executable script $BSUBNAM
    echo Please execute this script to process data
fi
