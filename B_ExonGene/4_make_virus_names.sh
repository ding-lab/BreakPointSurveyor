# Make a mapping of virus reference names to more convenient virus names
# This is ad hoc and for convenience in plotting only

# From: /gscmnt/gc7210/info/medseq/maw/Virus/Virus_2013.9a/analysis/Genbank/virus_codes.dat

source ./ExonGene.config

OUT="$OUTD/virus_names.dat"

cat <<EOF > $OUT
gi|9626053|ref|NC_001355.1| HPV6b 
gi|310698439|ref|NC_001526.2| HPV16 
gi|9626069|ref|NC_001357.1| HPV18 
gi|333048|gb|J04353.1|PPH31A HPV31 
gi|333049|gb|M12732.1|PPH33CG HPV33 
gi|333050|gb|M74117.1|PPH35CG HPV35 
gi|333245|gb|M62849.1|PPHT39 HPV39 
gi|145968370|gb|EF202167.1| HPV45 
gi|397038|emb|X74481.1| HPV52 
gi|138374746|gb|EF177177.1| HPV56 
gi|222386|dbj|D90400.1|PPH58 HPV58 
gi|557236|emb|X77858.1| HPV59 
gi|9627180|ref|NC_001538.1| BK 
gi|384597744|gb|JQ780693.1| HHV1 
gi|155573956|gb|AY446894.2| HHV5 
gi|21326584|ref|NC_003977.1| HBV 
gi|139424470|ref|NC_009334.1| EBV
gi|303291522|ref|NC_014407.1| Polyomavirus_HPyV7 
EOF

echo Written to $OUT
