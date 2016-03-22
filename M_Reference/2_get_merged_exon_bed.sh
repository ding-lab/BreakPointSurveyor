# Generate a BED file of all exons in GTF file, merging all overlapping exons into one feature

source ./M_Reference.config

TMP="$OUTD/../tmp"
mkdir -p $TMP

BIN="$BPS_CORE/src/annotation/GTFFilter.py"

function define_75 {
    #GTF="$OUTD/Homo_sapiens.GRCh37.75.gtf"
    GTF="$OUTD/RAD51B.37.75.gtf"
    OUT="$OUTD/exons.ens75.bed"
    ARGS="-e 75"
}

function define_84 {
    # GTF="$OUTD/Homo_sapiens.GRCh38.84.gtf"
    GTF="$OUTD/RAD51B.38.84.gtf"
    OUT="$OUTD/exons.ens84.bed"
    ARGS="-e 84"
}

TMP1="$TMP/all.exons.bed"        # temporary BED file of unsorted and unmerged exons
TMP2="$TMP/merged.exons.bed"     # temporary BED file of merged but unsorted exons
rm -f $TMP2; touch $TMP2

#define_75
define_84

#python $BIN $ARGS -s -b exon  < $GTF 
python $BIN $ARGS -s -b exon  < $GTF | bedtools sort -i stdin > $TMP1

#python $BIN -s -b exon  < $GTF | bedtools sort -i stdin > $TMP1
echo Written to $TMP1

# now go through genes one by one and and merge all their beds together
for GENE in `cut -f 4 $TMP1 | sort -u `; do
#fgrep -w $GENE $TMP1 | mergeBed -nms -i stdin | sed 's/;.*//' >> $TMP2
#fgrep -w $GENE $TMP1 | mergeBed -c 4 -o collapse  -i stdin | sed 's/;.*//' >> $TMP2
fgrep -w $GENE $TMP1 | mergeBed -c 4 -o collapse  -i stdin | sed 's/,.*//' >> $TMP2
done
echo Written to $TMP2

# Finally, keep just the leading gene name (they should all be the same).  Expand the gene name to recover strand info
bedtools sort -i $TMP2 | sed 's/:/\t.\t/' > $OUT
echo Written to $OUT

