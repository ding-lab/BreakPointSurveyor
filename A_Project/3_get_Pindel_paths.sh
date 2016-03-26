# These are the pindel read pairs with support in the child only:
#     /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/pindel/pindel/group0/merged_RP.raw.child_only
#     /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/pindel/pindel/group1/merged_RP.raw.child_only
#     /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/pindel/pindel/group2/merged_RP.raw.child_only
# These were derived from the files "merged_RP.raw" in the same directories.

source ./Project.config
OUT="$OUTD/1000SV.Pindel_RP.dat"

# turns out it is easier to assign the data by hand here.

cat <<EOF | sort | tr ' ' '\t' > $OUT
HG00514 /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/pindel/pindel/group0/merged_RP.raw.child_only
HG00733 /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/pindel/pindel/group1/merged_RP.raw.child_only
NA19240 /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/pindel/pindel/group2/merged_RP.raw.child_only
EOF

echo Written to $OUT
