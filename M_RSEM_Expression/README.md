# RSEM Expression

*Analyze TCGA RSEM expression in vicinity of integration events.*

This is closely related to workflow in L_Expression, but uses publicly available RPKM expression data
from [TCGA Firehose](http://gdac.broadinstitute.org/).

In L_Expression, RPKM expression data is evaluated by processing RNA-Seq data directly.
Here, RSEM expression data is obtained in a tabular pre-processed form from.
RPKM and RSEM data are used interchangeably for the purpose of this illlustrative example.
The primary difference in these two workflows stems from the fact that RPKM data lists only the
regions for which expression is evaluated, but not the associated gene names.  Workflow proceeds as follows:

1. `1_get_data.sh`. Download HNSC RSEM data from [TCGA Firehose](http://gdac.broadinstitute.org/).  This is a 1.3Gb file.
2. `2_make_BED.sh`.  Create a BED file which lists all genes +/- 1Mbp of integration event
3. `3_parse_RSEM.sh`.  Extract RSEM data only for regions which fall within the genes defined above, and associate with 
each domain a gene name; note that strand information is not used for this assignment, which may lead to incorrect results
in the case of two genes in the same position on opposite strands.  This step also creates an exon BED file which has strand
information for each exon in RSEM data.
4. `4_stream_exons.sh`. Process exon BED file created above and add "stream" information, indicating whether exon falls upstream
of an integration event, downstream of it, or whether it is inside an integration event.  This is necessary because we treat exons
upstream and downstream of integration events (and any withing it) separately for expression disregulation calculations.  
5. `5_evaluate_expression_Pvalue.sh`. Calculate expression of case samples relative to controls.  See 
[Algorithm Details](../L_Expression/AlgorithmDetails.md) for more information.


