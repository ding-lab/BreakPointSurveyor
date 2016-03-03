#Getting list of all "Dedifferentiated liposarcoma" tumor WGS samples.
#Work based on McLellan's work here:
#    /gscuser/mmclella/shared/TCGA_SARC/Samples/WGS_Selection/Selection3
#and 
#    /gscuser/mmclella/shared/TCGA_SARC/Samples/Clinical/2014-12-17
#
#1) get list of all Dedifferentiated liposarcoma samples (-> dat/DDLS.dat).  This uses McLellan's clinical data file
#   on gsc and is copy/pasted into dat/DDLS.dat
#
mkdir -p dat
OUT="dat/DDLS.dat"
DAT="/gscuser/mmclella/shared/TCGA_SARC/Samples/Clinical/2014-12-17/nationwidechildrens.org_clinical_patient_sarc.txt"

cut -f  1,18 $DAT | grep "Dedifferentiated liposarcoma" | cut -f 1 | sort -u > dat/DDLS.dat

echo Written to $OUT
