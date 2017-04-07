#Reference

*Construct minimal reference consisting only of GRCh38 chromosomes 9 and 22.*

To improve performance and demonstrate creation of custom reference, we create a smaller reference of just the 
chromosomes of interest.
* Download GRCh38 reference for chrom 9 and 22
* Concatenate these sequences and generate associated index.

Because reference is relatively large, store in an untracked directory

# Performance
* `1_get_GRCH38_chr9_chr22.sh` requires download of about 50Mb
* `2_prepare_reference.sh` takes about 5 minutes


