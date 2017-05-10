# Create synthetic BAM file aligned to human+virus reference
# this serves as a "synthetic normal" file for use with Novobreak

# WGSIM and BWA are defined in ../bps.config or ../bps.config.local

source ./BPS_Stage.config

U_OUTD="dat.untracked"

function align_reads {
    DAT1=$1
    DAT2=$2
    REF=$3
    OUT=$4

# bwa mem [options] <idxbase> <in1.fq> [in2.fq]
    CMD="$BWA mem $REF $DAT1 $DAT2" 

    echo Executing: $CMD
    echo Writing to $OUT

    $CMD | samtools sort -o $OUT -O bam -T tmp -
    samtools index $OUT
}

# This creates a BAM file aligned to the human+virus reference, with the reads
# themselves synthesized from the reference.  This is used as a "synthetic normal"
# for novobreak analysis.
# Synthetic BAM is created for the first reference seen in SAMPLE_LIST.  In general,
# would make one such BAM for each different reference

READS1="$U_OUTD/reads/synthetic.reads1.fq"
READS2="$U_OUTD/reads/synthetic.reads2.fq"

REF="/home/archive/mwyczalk/BreakPointSurveyor.TCGA_Data/GRCh37-lite-+-selected-virus-2013.9.a/all_sequences.fa"
OUT="$U_OUTD/synthetic_normal-9a.bam"

align_reads $READS1 $READS2 $REF $OUT

echo Written to $OUT

