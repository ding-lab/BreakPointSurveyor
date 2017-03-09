source ./Reference.config

# Download the GRCh37-lite human reference.  This a relatively large file (~1Gb compressed)
DAT=GRCh37-lite.fa.gz

pushd $OUTD
wget ftp://genome.wustl.edu/pub/reference/GRCh37-lite/$DAT
gunzip $DAT
popd $OUTD

# Will need to index it, etc.
