# Generate a BED file of exons in GTF file
#
# Support for Ensembl version 75 and 84.  See GTFFilter.py for details.
#
# For version 75, all exons from all transcripts are extracted.
# For version 84, keeping just a subset (canonical?) list of exons.
# in both cases, all overlapping exons are combined into one exon feature.
#
# This is a relatively slow process (several hours)
#
# File $OUTD/exons.ensXX.bed is generated, which is used to illustrate gene
# positions in BreakpointSurveyor plot.

source ./Reference.config
set +o posix

TMP="$OUTD/tmp"
mkdir -p $TMP

BIN="$BPS_CORE/src/annotation/GTFFilter.py"

# process Ensembl release 75
function define_75 {
GTF="$OUTD/Homo_sapiens.GRCh37.75.gtf.gz"
OUT="$OUTD/exons.ens75.bed"
ARG="-e 75"
}

# process Ensembl release 84
function define_84 {
GTF="$OUTD/Homo_sapiens.GRCh38.84.gtf.gz"
OUT="$OUTD/exons.ens84.bed"
ARG="-e 84"
}

define_75
#define_84
  
TMP1="$TMP/all.exons.bed"        # temporary BED file of unsorted and unmerged exons
TMP2="$TMP/merged.exons.bed"     # temporary BED file of merged but unsorted exons
rm -f $TMP2; touch $TMP2

python $BIN $ARG -s -b exon  < <(zcat $GTF) | bedtools sort -i stdin > $TMP1
echo Written to $TMP1

# now go through genes one by one and and merge all their beds together
for GENE in `cut -f 4 $TMP1 | sort -u `; do
fgrep -w $GENE $TMP1 | mergeBed -nms -i stdin | sed 's/;.*//' >> $TMP2
# newer versions of bedtools don't support -nms.  the following works with bedtools 2.24.0
# fgrep -w $GENE $TMP1 | mergeBed -c 4 -o collapse  -i stdin | sed 's/,.*//' >> $TMP2
done
echo Written to $TMP2

# Finally, keep just the leading gene name (they should all be the same).  Expand the gene name to recover strand info
bedtools sort -i $TMP2 | sed 's/:/\t.\t/' > $OUT
echo Written to $OUT

