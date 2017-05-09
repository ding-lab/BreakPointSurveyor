# Create synthetic BAM file aligned to human+virus reference
# this serves as a "synthetic normal" file for use with Novobreak

# WGSIM and BWA are defined in ../bps.config or ../bps.config.local

source ./BPS_Stage.config

function synthesize_reads {
    # wgsim [options] <in.ref.fa> <out.read1.fq> <out.read2.fq>
    # Make reads be 126bp in length

    # we use the human+virus reference as the source of our reads.
    REF=$1
    OUT1=$2
    OUT2=$3

    NREADS=10

    ARGS="-N $NREADS -1 126 -2 126"

    $WGSIM $ARGS $REF $OUT1 $OUT2 > $OUTD/reads/wgsim.log
    echo Written to $OUT1 and $OUT2
}

# Create reads based on the human+virus reference.  This is used as a "synthetic normal"
# for novobreak analysis.

mkdir -p $OUTD/reads
READS1="$OUTD/reads/synthetic.reads1.fq"
READS2="$OUTD/reads/synthetic.reads2.fq"

REF="/home/archive/mwyczalk/BreakPointSurveyor.TCGA_Data/GRCh37-lite-+-selected-virus-2013.9.a/all_sequences.fa"

synthesize_reads $REF $READS1 $READS2


