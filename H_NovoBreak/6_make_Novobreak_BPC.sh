source ./BPS_Stage.config

# Create BPC file based on novoBreak vcf output

BIN="$BPS_CORE/src/util/processVCF.py"

# Convert novoBreak VCF to BPC format
# processVCF.py relies on the pyvcf library for parsing vcf files: http://pyvcf.readthedocs.io/en/latest/API.html
# The VCF format as output by the novoBreak scripts doesn't seem to follow this format precisely, causing errors
# during parsing.  To get around this, we retain only the first nine columns of the VCF file.

function process {
    BAR=$1
    DAT="$OUTD/novobreak/$BAR/novoBreak.pass.flt.vcf"
    OUT="$OUTD/novobreak/$BAR/novoBreak.bpc.dat"

    # We filter the output of processVCF.py to retain only those breakpoints where chromA != chromB, i.e., only inter-chromosomal translocations
    awk 'BEGIN{FS="\t"; OFS="\t"}{if ($1 ~ "^#") print; else print $1,$2,$3,$4,$5,$6,$7,$8,$9}' $DAT | python $BIN bpc | awk 'BEGIN{FS="\t"; OFS="\t"}{if ($1 != $3) print}' > $OUT

    echo Written to $OUT
}

# Again, focusing only on BA-4077

BAR=`grep BA-4077 $SAMPLE_LIST | awk '{print $1}'`

process $BAR 
