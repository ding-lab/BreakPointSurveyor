source ./BPS_Stage.config

# Create BAM file which only includes reads from region of interest, to streamline
# downstream processing.

U_OUTD="dat.untracked"

# Usage: merge combined.bam a.bam b.bam ...
function merge {
    OUT=$1
    shift

    echo Merging $@ into $OUT

    samtools merge -f $OUT $@
    samtools index $OUT

}

BAM="$U_OUTD/BA-4077.ROI.bam"
merge $BAM $U_OUTD/BA-4077.chr14.bam $U_OUTD/BA-4077.HPV16.bam

# NA19240.AQ?.bam can be deleted
