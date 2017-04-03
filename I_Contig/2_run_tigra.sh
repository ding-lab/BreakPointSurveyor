# Run Tigra-SV on all samples of interest.
# Support provided for cluster queuing system (bsub)
# Turn queuing on/off with USE_BSUB=1/0
USE_BSUB=0

source ./BPS_Stage.config

# TIGRA is defined in ../bps.config

if [ $USE_BSUB == 1 ]; then    
    # using bsub
    mkdir -p bsub
fi  
mkdir -p $OUTD/contig

function process {
    BAR=$1
    BAM=$2
    FASTA=$3

    CTX="$OUTD/CTX/${BAR}.ctx"
    OUT="$OUTD/contig/${BAR}.contig"

#    if [ -e $OUT ]; then
#        echo $OUT exists.  Skipping.
#        continue
#    fi

    # adding -m flag, supported under 0.4.2
    CMD="$TIGRA -o $OUT -R $FASTA -b $CTX -m $BAM"

    if [ $USE_BSUB == 1 ]; then    
        bsub -oo bsub/$BAR.bsub $CMD   # this is functional
    else
        echo Executing: $CMD
        $CMD
    fi  
}

while read l; do  # iterate over all rows of samples.dat
# barcode	disease BAMpath	RPpath	REFpath	batch
# TCGA-BA-4077-01B-01D-1431-02	HNSC    ...d436.bam	.../TCGA-BA-4077-01B-01D-1431-02_RP	.../all_sequences.fa	Normals.9a

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

BAR=`echo $l | awk '{print $1}'`
BAM=`echo $l | awk '{print $3}'`
FASTA=`echo $l | awk '{print $4}'`

process $BAR $BAM $FASTA

done < $SAMPLE_LIST
