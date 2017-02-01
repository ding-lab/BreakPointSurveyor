# normalize chrom names to those in the reference.
# In particular, modify chrom names in Ensembl84-derived data (genes, exons BED)
# to match the reference.
#
# Procedure is based on mapping here: https://github.com/dpryan79/ChromosomeMappings/blob/master/GRCh38_ensembl2gencode.txt
# (see https://www.biostars.org/p/138011/ )
#
# Here, rename exons and genes BED files.
#
# Not needed for Ensembl75

source ./M_Reference.config

FN="GRCh38_ensembl2gencode.txt"
MAP="$OUTD/$FN"
BIN="$BPS_CORE/src/annotation/ChromRenamer.py"

function rename_chrom {
    IN=$1
    OUT=$2

    $BIN -i $IN -o $OUT $MAP
    echo Written to $OUT
}

rename_chrom $OUTD/genes.ens84.bed $OUTD/genes.ens84.norm.bed
rename_chrom $OUTD/exons.ens84.bed $OUTD/exons.ens84.norm.bed

