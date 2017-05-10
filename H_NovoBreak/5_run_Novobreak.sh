# Start Novobreak

source ./BPS_Stage.config

# Invocation of run_novoBreak.sh, from README in NOVOBREAK_DIR defined in ../bps.config
# bash <A_PATH>/novoBreak/run_novoBreak.sh <novoBreak_exe_dir> <ref> <tumor_bam> <normal_bam> <n_CPUs:INT> [outputdir:-PWD]

RUN_NOVOBREAK="src/run_novoBreak.sh"

U_OUTD="dat.untracked"
mkdir -p $U_OUTD

function process {
    BAR=$1
    TUMOR_BAM=$2
    REF=$3

    NORMAL_BAM="$U_OUTD/synthetic_normal-9a.bam"

    U_OUTDD="$U_OUTD/novobreak/$BAR"
    mkdir -p $U_OUTDD

    bash $RUN_NOVOBREAK $NOVOBREAK_DIR $REF $TUMOR_BAM $NORMAL_BAM 4 $U_OUTDD

    if [ -f $U_OUTDD/novoBreak.pass.flt.vcf ]; then
        echo Novobreak analysis of $BAR appears to have completed successfully.
        OUTDD="$OUTD/novobreak/$BAR"
        mkdir -p $OUTDD
        cp $U_OUTDD/novoBreak.pass.flt.vcf $OUTDD
        echo Written to $OUTDD/novoBreak.pass.flt.vcf
    else
        echo Novobreak analysis of $BAR appears to have failed.
    fi
        
}

# process only BA-4077

BAR=`grep BA-4077 $SAMPLE_LIST | awk '{print $1}'`
BAM="$U_OUTD/BA-4077.ROI.bam"
REF=`grep BA-4077 $SAMPLE_LIST | awk '{print $4}'`

process $BAR $BAM $REF
    

