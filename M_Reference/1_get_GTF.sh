# Download Ensembl GTF file for a given release

GTF="Homo_sapiens.GRCh37.75.gtf.gz"
SRC="ftp.ensembl.org/pub/release-75/gtf/homo_sapiens/$GTF"
DEST="dat"

mkdir -p $DEST
pushd $DEST
wget $SRC 
gunzip -v $GTF
popd
