# obtain directory location for somatic variation models of SARC DDLS samples.
#   Model ID refers to "TCGA Sarcoma WGS Somatic Models" Model Group
# barcode names are renamed to the begin with TCGA
# Only succeeded builds are retained

# Calls MGI-specific database 
# filters for DDLS participant IDs
# Writes dat/SARC_DDLS.somatic_variation.dat

# it turns out that some barcodes appear in somatic variation build more than once.
# as a result, the output file here has duplicates and more than one place to obtain CTX
# data.  To keep things simple, request that user modifies this file manually to exclude
# duplicates and make downstream merge easy

LIST="dat/DDLS.dat"
MODEL_ID="49b5bfdec8d84b79946640611892fa17"
OUT="dat/TCGA_SARC.somatic_variation.dat"

genome model build list model_groups.id=$MODEL_ID --show subject.name,data_directory,status --noheader --style=tsv | grep Succeeded | sed 's/H_MV/TCGA/' | grep -f $LIST | cut -f 1,2 | sort > $OUT

echo The following barcodes appear more than once in $OUT
echo Please edit this file manully as necessary to exclude duplicates
cut -f 1 $OUT | sort | uniq -c | sort -nr | awk '{if ($1 > 1) print}'

echo Written to $OUT
