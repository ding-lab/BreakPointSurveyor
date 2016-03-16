# update list of SARC DDLS tumors to add data directory

DAT="dat/DDLS_WGS_tumor.bam_path.pre.dat"
OUT="dat/DDLS_WGS_tumor.dat"

echo -e "barcode\tbam_path\tbuild_id\tdata_path" > $OUT

while read l; do  
# TCGA-DX-A1KU-01A-32D-A24N-09    /gscmnt/gc12001/info/build_merged_alignments/merged-alignment-blade16-4-12.gsc.wustl.edu-apipe-builder-20391-50d4b25abdbb4397bffe5eb4807c9d52/50d4b25abdbb4397bffe5eb4807c9d52.bam  5b49e283c0754484b308e37d13e53a98


BAR=`echo $l | awk '{print $1}'`
BAM=`echo $l | awk '{print $2}'`
MID=`echo $l | awk '{print $3}'`
echo $BAR 

DP=`genome model build list build_id=$MID --show data_directory --noheaders`
echo -e "$BAR\t$BAM\t$MID\t$DP" >> $OUT

done < $DAT

echo Written to $OUT
