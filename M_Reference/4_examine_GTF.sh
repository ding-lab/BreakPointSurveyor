# Example script for examining GTF files.
# TLAExamine.R makes GTF files easier to analyze and view in e.g. spreadsheet by expanding
# all the attributes as uniform columns.  It is probably too slow to be used for genome-wide
# analysis but is useful for exploratory work

source ./M_Reference.config
BIN="$BPS_CORE/src/annotation/TLAExamine.R"

set +o posix  # enable process substitution.  Alternative is to use TMP code

GENE=RAD51B # extract and examine all features associated with this gene

GTF="$OUTD/Homo_sapiens.GRCh37.75.gtf.gz"
OUT="$OUTD/${GENE}.37.75.gtf.tsv"

#GTF="$OUTD/Homo_sapiens.GRCh38.84.gtf.gz"
#OUT="$OUTD/${GENE}.38.84.gtf.tsv"

# Using this to create test GTF files
# OUT="$OUTD/${GENE}.37.75.gtf"
# zcat $GTF | fgrep $GENE > $OUT
# echo WRitten to $OUT
# exit

Rscript $BIN -m gtf < <(zcat $GTF | fgrep $GENE) > $OUT

echo Written to $OUT

