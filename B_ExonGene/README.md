# ExonGene

*Reference-specific analysis and files.*

This directory contains gene and exon definitions for builds GRCh37 and GRCH38, based on 
Ensembl releases 75 and 84, respectively.  The workflow here will reproduce these datasets,
but that is typically not necessary.  In most cases there is nothing to do for this stage.

Key files here are,

* `dat/genes.ensXX.bed` contains gene definitions
* `dat/exons.ensXX.bed` contains exon definitions

### Development notes

For annotation purposes, we require that gene names match in all genes and exons so they are drawn together.
Exons may have optional labels separated by ":" from gene name (see `Synthetic` branch for details).

Workflow here parses Ensemble GTF file directly to pull out genes and exons.  Details of the selection process
are in `GTFFilter.py`.  They are ad hoc and vary according to ensembl version.  There may be better and
more standard ways to obtain gene and exon definitions, which would replace the work here.

We provide a script `src/TLAExamine.R` (see `x.5_examine_GTF.sh`)
which conveniently examines GTF files by expanding the attributes column into
multiple columns.  It is useful for debugging and understanding these files better.

`2_get_merged_exon_bed.sh` and `3_get_gene_bed.sh` are production scripts which extract genes and exons
    from GTF file.  These need to be run just once and then the resulting features file can be used
    for downstream applications.

Steps starting with `x` are optional or may be necessary only for certain ensembl releases 
