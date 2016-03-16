OUT="tar/CTX.tar.gz"
mkdir -p tar

tar -zcf $OUT dat/Combined.PlotList.50K.dat dat/*.BPC.dat

echo Written to $OUT
