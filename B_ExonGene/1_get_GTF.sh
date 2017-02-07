# Download Ensembl GTF file for a given release
source ./ExonGene.config

GTF="Homo_sapiens.GRCh37.75.gtf.gz"
SRC="ftp.ensembl.org/pub/release-75/gtf/homo_sapiens/$GTF"
#GTF="Homo_sapiens.GRCh38.84.gtf.gz"
#SRC="ftp.ensembl.org/pub/release-84/gtf/homo_sapiens/$GTF"
DEST="$OUTD"

mkdir -p $DEST
pushd $DEST
wget $SRC 

# not uncompressing
# gunzip -v $GTF
popd
