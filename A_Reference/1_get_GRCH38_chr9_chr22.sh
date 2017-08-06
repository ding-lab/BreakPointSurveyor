source ./BPS_Stage.config

# Download the GRCh38 human reference chr9 and chr22 and merge to combined
# chrom.  Note the reference is relatively large and will not be saved on git
SRC=http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/

UNTRACKED_DIR=$OUTD
mkdir -p $UNTRACKED_DIR

function download {
DAT=$1
pushd $UNTRACKED_DIR
wget $SRC/$DAT
gunzip -f $DAT
popd 
}

# downloading two chromosomes only
download chr9.fa.gz
download chr22.fa.gz
