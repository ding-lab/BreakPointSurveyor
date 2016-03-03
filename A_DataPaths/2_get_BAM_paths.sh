# Make a list of all DDLS SARC WGS tumor samples, their BAM paths, and model IDs

DAT="/gscuser/mwyczalk/projects/public/TCGA_Status/data/GMT_SARC_WGS.dat"
OUT="dat/DDLS_WGS_tumor.bam_path.pre.dat"
LIST="dat/DDLS.dat"

#     1  CGHub_ID
#     2  TCGA_Name
#     3  Instrument_ID
#     4  Model_ID
#     5  Reference_ID
#     6  Processing_ID
#     7  Build_ID
#     8  BAM_path
#     9  Comment

# TCGA-DX-A2IZ-10A-01D-A21Q-09
# 1234567890123456789012345678


# genome model build list build_id=5b49e283c0754484b308e37d13e53a98 --show data_directory --noheaders

grep -f $LIST $DAT | cut -f 2,7,8,9 | grep -v "Not Imported" | awk 'BEGIN{FS="\t";OFS="\t"}{if (substr($1,14,2) == "01") print $1,$3,$2}' | sort -u  > $OUT
echo Written to $OUT
