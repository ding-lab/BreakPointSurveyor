source ./BPS_Stage.config

# Create BAM file which only includes reads from region of interest, to streamline
# downstream processing.
#
# It would be simpler to use `samtools view -L BED` to extract segments of the BAM/CRAM
# file, but performance is really slow.  Instead, we'll extract regions one by one, and
# then merge the BAM files individually.

# ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/data/YRI/NA19240/high_cov_alignment/NA19240.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram
BAM_ORIG="/diskmnt/Datasets/1000G_SV/ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/data/YRI/NA19240/high_cov_alignment/NA19240.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram"

U_OUTD="dat.untracked"
mkdir -p $U_OUTD


# Extracts BAM file from NA19240 for given region 
function process {
    CHR=$1
    START=$2
    END=$3
    NAME=$4

#   REG="chr10:41804249-41965847"
    REG="$CHR:$START-$END"
    OUT="$U_OUTD/NA19240.$NAME.bam"

    # samtools view -L is very slow.
    # instead do this once for multiple regions

    #samtools view -T $REF -b -o $OUT $BAM_ORIG $REG
    echo Processing $REG
    samtools view -b -o $OUT $BAM_ORIG $REG

    echo Written to $OUT
}

function process_BED {
    BED=$1
    while read l
    do
        # Skip comments 
        [[ $l = \#* ]] && continue

        process $l
    done < $BED
}

function merge {
    samtools index $OUT

}

# Obtain BAM file for all regions of interest in BAM
process_BED $OUTD/1000SV.ROI.bed
