source ./Project.config

# Create BAM file which only includes reads from region of interest, to streamline
# downstream processing.

# Usage: merge combined.bam a.bam b.bam ...
function merge {
    OUT=$1
    shift

    echo Merging $@ into $OUT

#    samtools merge $OUT $@
    samtools index $OUT

}

merge $OUTD/NA19240.AQ.bam $OUTD/NA19240.AQ?.bam
merge $OUTD/NA19240.AU.bam $OUTD/NA19240.AU?.bam

# NA19240.AQ?.bam can be deleted
