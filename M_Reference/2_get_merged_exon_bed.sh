# Generate a BED file of all exons in GTF file, merging all overlapping exons into one feature

mkdir -p tmp
mkdir -p dat

BIN="../../BreakpointSurveyor/src/annotation/GTFFilter.py"

GTF="dat/Homo_sapiens.GRCh37.75.gtf"
#GTF="GTF/TCGA-BA-4077-01B-01D-2268-08.gtf"


OUT="dat/exons.ens75.bed"
  
TMP1="tmp/all.exons.bed"        # temporary BED file of unsorted and unmerged exons
TMP2="tmp/merged.exons.bed"     # temporary BED file of merged but unsorted exons
rm -f $TMP2; touch $TMP2

python $BIN -s -b exon  < $GTF | bedtools sort -i stdin > $TMP1
echo Written to $TMP1

# now go through genes one by one and and merge all their beds together
for GENE in `cut -f 4 $TMP1 | sort -u `; do
fgrep -w $GENE $TMP1 | mergeBed -nms -i stdin | sed 's/;.*//' >> $TMP2
done
echo Written to $TMP2

# Finally, keep just the leading gene name (they should all be the same).  Expand the gene name to recover strand info
bedtools sort -i $TMP2 | sed 's/:/\t.\t/' > $OUT
echo Written to $OUT

