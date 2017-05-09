# Start Novobreak

source ./BPS_Stage.config

# # This BED file lists just the virus genomes
# # This makes Pindel faster by focusing only on virus/virus and virus/human breakpoints
# BED="$BPS_DATA/A_Reference/dat/GRCh37_selectVirus_9a.bed"

# Invocation of run_novoBreak.sh, from README in NOVOBREAK_DIR defined in ../bps.config
# bash <A_PATH>/novoBreak/run_novoBreak.sh <novoBreak_exe_dir> <ref> <tumor_bam> <normal_bam> <n_CPUs:INT> [outputdir:-PWD]

RUN_NOVOBREAK="$NOVOBREAK_DIR/run_novoBreak.sh"

function process {
    BAR=$1
    TUMOR_BAM=$2
    REF=$3

    NORMAL_BAM="$OUTD/synthetic_normal-9a.bam"

    OUTDD="$OUTD/novobreak/$BAR"
    mkdir -p $OUTDD

    bash $RUN_NOVOBREAK $NOVOBREAK_DIR $REF $TUMOR_BAM $NORMAL_BAM 1 $OUTDD
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
