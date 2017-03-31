#Reference

* Define path to BWA in `2_prepare_reference.sh`

Creating custom reference for Synthetic analysis, consisting only of GRCh38 chromosomes 9 and 22.
This reference is smaller and demonstrates custom reference generation.

After reference is created, make associated index files.  This requires bwa and samtools.

Because reference is relatively large, store in an untracked directory

Timing:

* Step 1 requires download of about 50Mb
* Step 2 takes about 5 minutes
