#GTF="dat/Homo_sapiens.GRCh37.75.gtf"
#OUT="dat/genes.ens75.bed"

source ./BPS_Stage.config
set +o posix

BIN="$BPS_CORE/src/annotation/GTFFilter.py"


# process Ensembl release 75
function define_75 {
GTF="$OUTD/Homo_sapiens.GRCh37.75.gtf.gz"
OUT="$OUTD/genes.ens75.bed"
ARG="-e 75"
}

# process Ensembl release 84
function define_84 {
GTF="$OUTD/Homo_sapiens.GRCh38.84.gtf.gz"
OUT="$OUTD/genes.ens84.bed"
ARG="-e 84"
}

define_75
# define_84
  
python $BIN $ARG -b gene < <(zcat $GTF) | bedtools sort -i stdin > $OUT

echo Written to $OUT
