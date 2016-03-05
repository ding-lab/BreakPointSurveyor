OUT="tar/DEPTH.tar.gz"
mkdir -p tar

tar -zcf $OUT DEPTH

echo Written to $OUT
