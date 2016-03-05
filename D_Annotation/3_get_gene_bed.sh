GTF="dat/Homo_sapiens.GRCh37.75.gtf"
OUT="dat/genes.ens75.bed"

BIN="../../BreakpointSurveyor/src/annotation/GTFFilter.py"

python $BIN -b gene < $GTF | bedtools sort -i stdin > $OUT

echo Written to $OUT
