# normalize chrom names to those in the reference.
# In particular, modify chrom names in Ensembl84-derived data (genes, exons BED)
# to match the reference.
#
# Procedure is based on mapping here: https://github.com/dpryan79/ChromosomeMappings/blob/master/GRCh38_ensembl2gencode.txt
# (see https://www.biostars.org/p/138011/ )
#
# Here, just download the mapping file

source ./M_Reference.config

FN="GRCh38_ensembl2gencode.txt"
OUT="$OUTD/$FN"

SRC="https://raw.githubusercontent.com/dpryan79/ChromosomeMappings/master/$FN"
wget $SRC -O $OUT
echo Writtent to $OUT

