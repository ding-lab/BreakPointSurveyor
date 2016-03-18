# My BreakDancer calls are in
#    /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/breakdancer/breakdancer/group*/{ITX,CTX}/*triofilter_pass
# where calls were deemed to have passed if there were supporting reads from child only.
OUT="dat/1000SV.CTX.dat"

# turns out it is easier to assign the data by hand here.

cat <<EOF | sort | tr ' ' '\t' > $OUT
HG00514 /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/breakdancer/breakdancer/group0/CTX/breakdancer.group0.ctx.triofilter_pass
HG00733 /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/breakdancer/breakdancer/group1/CTX/breakdancer.group1.ctx.triofilter_pass
NA19240 /gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/breakdancer/breakdancer/group2/CTX/breakdancer.group2.ctx.triofilter_pass
EOF




echo Written to $OUT
