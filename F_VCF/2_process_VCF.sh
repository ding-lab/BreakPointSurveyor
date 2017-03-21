
# Note that VCF below does not have NA19240 and is GRCh37
DAT="dat/ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
# past work with liftover here: /gscuser/mwyczalk/projects/1000SV/1000SV.analysis


# DAT="/home/mwyczalk_test/data/1000SV/SVelter.NA19240/dat/SV.19240.TRA.vcf.gz"

source ./VCF.config

function process_vcf {
    CHROM=$1  # 1, 2...
    SAMPLE=$2
    VCF=$3
    OUT=$OUTD/$SAMPLE.chr$CHROM.vcf

# Note that coordinates for events are in GRCh38
# "AU" event: chr13:62947705-63061713	to chr17:221247350-22180085	
    FROM="60000000"
    TO="65000000"

    # Remove all AC=0 variants.
    # below works with the 1000SV VCF, but find no SVTYPE events in region of interest
    # bcftools view -c 1 $VCF $CHROM:$FROM-$TO > $OUT


    bcftools view -s $SAMPLE $VCF $CHROM:$FROM-$TO > $OUT
    #bcftools view $VCF $CHROM:$FROM-$TO > $OUT
    #bcftools view $VCF > $OUT
    echo Written to $OUT
}

SAMPLE="NA19238"
CHROM="13"  # this for 1000SV VCF
#CHROM="chr13"

process_vcf $CHROM $SAMPLE $DAT
