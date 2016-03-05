# Example script for examining GTF files.
# TLAExamine.R makes GTF files easier to analyze and view in e.g. spreadsheet by expanding
# all the attributes as uniform columns.  It is probably too slow to be used for genome-wide
# analysis but is useful for exploratory work

set +o posix  # enable process substitution.  Alternative is to use TMP code

GENE=RAD51B # extract and examine all features associated with this gene
BIN="../../BreakpointSurveyor/src/annotation/TLAExamine.R"

#mkdir -p tmp
mkdir -p dat
GTF="dat/Homo_sapiens.GRCh37.75.gtf"
#TMP="tmp/${GENE}.gtf"
OUT="dat/${GENE}.gtf.tsv"

#fgrep $GENE $GTF > $TMP

Rscript $BIN -m gtf < <(fgrep $GENE $GTF) > $OUT

echo Written to $OUT

