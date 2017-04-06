# Per-Gene Expression Calculations

The expression of all exons in a gene is combined to yield per-gene
P-value.  When an integration event occurs within a gene, we treat upstream,
intra-gene, and downstream exons independently (i.e., consider 3 separate "genes").

## Per-gene permutation test (repeated once for every gene)

Exons of interest are all the exons within the gene being considered.

Expression values (e.g., RPKM) for all exons of interest for all samples (case and control) are represented by vector X.
Vector A\* enumerates all case exons (length(A\*) is the exon count), so that X(A\*) is a vector
of all case exon expression.  Likewise, B\* is vector of all control exons, and X(B\*) represents
all control exon expression.  (The union of X(A\*) and X(B\*) then consists of all of X).

We define case deviance as d\*=abs( ave(X(A\*)) - ave(X(B\*)) ), where abs() and ave() are absolute value and
average functions, respectively.

Similarly, we define case difference of means as e\*=ave(X(A\*)) - ave(X(B\*)).

Next, we generate Ai as a vector of random indices into X, with
length(Ai)=length(A\*).  Likewise, Bi is generated from Ai as the "leftover"
indices (all exons not in Ai).  This is done many times, with i=1..nA.  nA is
chosen by the user to keep computation time manageable.

We then define null variance as, di = abs( ave(X(Ai)) - ave(X(Bi)) ).  The
assumption underlying this permutation test is that di approximates the null
distribution of the deviance - what we would see if A\* and B\* were drawn from
the same distribution.

The probability that A\* (case observations) are drawn from the null
distribution is calculated as, 

p = 1/(2\*nA) ( count(di > d\*) + count(di >= d\*) )

(The two count terms allow us to deal cleanly with cases of e.g. multiple values of zero expression in an exon)

The smaller the value of p, the more likely it is that this gene in the case is
significantly dysregulated with respect to this gene in the control samples.
The direction of this dysregulation is given by e\*: gene expression is
upregulated if e\* > 0, downregulated if e\* < 0.

We then perform multiple test correction ([Benjamini and Hochberg, 1995](http://www.jstor.org/stable/2346101?seq=1#page_scan_tab_contents)) to obtain per-gene FDRs.
