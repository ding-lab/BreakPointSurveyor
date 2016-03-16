# obtain directory location for somatic variation models of SARC DDLS samples.
# model names are renamed to the begin with TCGA
# Only succeeded builds are retained

LIST="dat/DDLS.dat"
MODEL_ID="49b5bfdec8d84b79946640611892fa17"
OUT="dat/SARC_DDLS.somatic_variation.dat"

genome model build list model_groups.id=$MODEL_ID --show subject.name,data_directory,status --noheader --style=tsv | grep Succeeded | sed 's/H_MV/TCGA/' | grep -f $LIST | cut -f 1,2 > $OUT

echo Written to $OUT
