# Extract from BAMs all virus reads and human->virus paired-end discordant reads
# Two files are created for each BAM:
# * virus_XXX.sam - has all reads which contain a virus
# * discordant_XXX.sam - subset of above which has just reads which map to human whose mate maps to virus

# Skips samples which have already been processed, so that this script 
# can be run repeatedly as additional samples finish alignment.

# Support provided for cluster queuing system (bsub)
# - Creates a processing script $BSUBNAM, which can be executed locally or on cluster
# Turn on queuing by setting USE_BSUB=1
USE_BSUB=0

source ./BPS_Stage.config

if [ $USE_BSUB == 1 ]; then    
    # using bsub
    mkdir -p bsub
    BSUBNAM="run_all_bsub.sh"
    rm -f $BSUBNAM
    echo "# This file created automatically by $0" >  $BSUBNAM
fi  

# Not tracking sam files due to TCGA restrictions
U_OUTD="dat.untracked"
mkdir -p $U_OUTD

function process {
    BAR=$1
    BAM=$2

    # First, print all viral reads (into VOUT)
    # Then, process VOUT to get just the discordant reads (written to DOUT)
    VOUT="$U_OUTD/virus_$BAR.sam"
    DOUT="$U_OUTD/discordant_$BAR.sam"

    if [ -f $VOUT ]; then # this is a safety thing so data not clobbered.  It can be discarded if necessary
        echo Skipping $BAR because $VOUT exists.
        continue
    fi
    echo Processing $BAR

    # TODO: it would be helpful to split this into two independent steps:
    #   1. extract virus reads (SHCMD1) - this is the part that may want to use bsub
    #   2. extract discordant reads (SHCMD2) - this part is much faster, doesn't need bsub
    # Splitting these up would make step-by-step processing easier.
    #
    # assuming that all virus references start with 'gi'.  We don't evaluate human-human discordant reads here
    SHCMD1="samtools view  $BAM | awk 'BEGIN{FS=\"\t\"} {if ((\$3 ~ /^gi/) || (\$7 ~/^gi/))  print}' > $VOUT"
    # keeping just those pairs which map from human to virus
    SHCMD2="awk 'BEGIN{FS=\"\t\"} {if ( (\$3 !~ /^gi/) && (\$7 ~ /^gi/) && (\$7 !~ /=/)) print}' $VOUT > $DOUT"

    if [ $USE_BSUB == 1 ]; then
        SHNAM="bsub/run_$BAR.sh"
        echo $SHCMD1 >  $SHNAM
        echo $SHCMD2 >> $SHNAM

        echo "bsub -o bsub/$BAR.out -e bsub/$BAR.err sh $SHNAM" >> $BSUBNAM
    else
        echo $SHCMD1 | sh
        echo Written to $VOUT
        echo $SHCMD2 | sh
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
