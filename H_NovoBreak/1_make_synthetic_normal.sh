# Create synthetic BAM file aligned to human+virus reference
# this serves as a "synthetic normal" file for use with Novobreak

# WGSIM and BWA are defined in ../bps.config or ../bps.config.local

source ./BPS_Stage.config

U_OUTD="dat.untracked"
mkdir -p $U_OUTD

function synthesize_reads {
    # wgsim [options] <in.ref.fa> <out.read1.fq> <out.read2.fq>
    # Make reads be 126bp in length

    # we use the human+virus reference as the source of our reads.
    REF=$1
    OUT1=$2
    OUT2=$3

    NREADS=10

    ARGS="-N $NREADS -1 126 -2 126"

    $WGSIM $ARGS $REF $OUT1 $OUT2 > /dev/null
    echo Written to $OUT1 and $OUT2
}

# Create reads based on the human+virus reference.  This is used as a "synthetic normal"
# for novobreak analysis.

mkdir -p $U_OUTD/reads
READS1="$U_OUTD/reads/synthetic.reads1.fq"
READS2="$U_OUTD/reads/synthetic.reads2.fq"

REF=`grep "BA-4077" $SAMPLE_LIST | cut -f 4`

synthesize_reads $REF $READS1 $READS2


