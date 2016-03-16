OUT="tar/CTX.tar.gz"
mkdir -p tar

tar -zcf $OUT dat/*.BPC.dat

echo Written to $OUT
