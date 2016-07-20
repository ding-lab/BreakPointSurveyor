# Run Tigra-SV on all samples of interest.
# Support provided for cluster queuing system (bsub)
# Turn on queuing by uncommenting line below
USE_BSUB=1

source ./Contig.config

# Tigra version used is 0.4.2; see https://bitbucket.org/xianfan/tigra

BIN="/gscuser/mwyczalk/src/tigra-0.4.2/tigra/tigra-sv"

DAT="$BPS_DATA/A_Project/dat/TCGA_Virus.samples.dat"

if [ ! -z $USE_BSUB ]; then
# using bsub
mkdir -p bsub
fi  
mkdir -p $OUTD/contig

while read l; do  # iterate over all rows of samples.dat
# barcode	BAMpath	RPpath	REFpath	batch
# TCGA-BA-4077-01B-01D-1431-02	...d436.bam	.../TCGA-BA-4077-01B-01D-1431-02_RP	.../all_sequences.fa	Normals.9a

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

BAR=`echo $l | awk '{print $1}'`
BAM=`echo $l | awk '{print $2}'`
FASTA=`echo $l | awk '{print $3}'`

CTX="$OUTD/CTX/${BAR}.ctx"
OUT="$OUTD/contig/${BAR}.contig"

if [ -e $OUT ]; then
echo $OUT exists.  Skipping.
continue
fi

# adding -m flag, supported under 0.4.2
CMD="$BIN -o $OUT -R $FASTA -b $CTX -m $BAM"

if [ -z $USE_BSUB ]; then
    echo Executing: $CMD
    $CMD
else
    bsub -oo bsub/$BAR.bsub $CMD   # this is functional
fi  

done < $DAT
