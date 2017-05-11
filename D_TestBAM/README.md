# Make BAMs
*Construct a variety of synthetic BAMs to demonstrate simple breakpoint*

The basic workflow is based on `../C_Project`.  Here, creating other types of simple
structural events for demonstration purposes.

## Intrachromosomal inversion

The majority of sample workflows in BreakpointSurveyor consist of INTERchromosomal translocation,
of which virus integratin is a special case.  Here, we demonstrate an INTRAchromosomal event.

### IntraA.bam

Consists of three concatenated segments AC'B, where

* Segment A : chr9:130,840,000-130,850,000 ( 10Kbp )
* Segment B : chr9:130,850,000-130,860,000 ( 10KBp, adjacent to A )
* Segment C : chr9:131,855,000-131,860,000 ( 5Kbp, some other region of chrom 9 )
    * Segment C' : reverse sequence of Segment C

