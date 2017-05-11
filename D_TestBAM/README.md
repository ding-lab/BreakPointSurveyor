# Make BAMs
*Construct a variety of synthetic BAMs to demonstrate simple breakpoint*

The basic workflow is based on `../C_Project`.  Here, creating other types of simple
structural events for demonstration purposes.

## Intrachromosomal inversion

The majority of sample workflows in BreakpointSurveyor consist of INTERchromosomal translocation,
of which virus integratin is a special case.  Here, we demonstrate an INTRAchromosomal event.

### IntraA.bam

Consists of three concatenated segments AC'B, where
* Segment A : chr9:36833000,36843000 ( 10Kbp )
* Segment B : chr9:36843000,36853000( 10KBp, adjacent to A )
* Segment C : chr9:37843000,37853000 ( 10Kbp, some other region of chrom 9 )
    * Segment C' : reverse complement of Segment C

The segments are chosen relatively randomly, taking care they don't fall onto repetitive regions
