source ./BPS_Stage.config

# Create BAM file which only includes reads from region of interest, to streamline
# downstream processing.

U_OUTD="dat.untracked"

# Usage: merge combined.bam a.bam b.bam ...
function merge {
    OUT=$1
    shift

    echo Merging $@ into $OUT

    samtools merge $OUT $@
    samtools index $OUT

}

merge $U_OUTD/NA19240.AQ.bam $U_OUTD/NA19240.AQ?.bam
merge $U_OUTD/NA19240.AU.bam $U_OUTD/NA19240.AU?.bam

# NA19240.AQ?.bam can be deleted
