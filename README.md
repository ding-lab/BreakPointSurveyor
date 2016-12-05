Workflow Architecture 

There are three layers of Breakpoint Surveyor project:
* BPS Core: core analysis and plotting, typically in R or Python
* BPS Workflow: Project- and locale-specific workflows.  Mostly as BASH scripts
* BPS Data: BPS-generated secondary data, graphical objects, and plots

In particular, workflow scripts do not write to e.g., ./dat.  Rather, they write to $BPSD/A_Project/dat
The idea is that the BPS.Data projects can be (optionally) managed by git and be independent of the project-level workflow.

This is the BPS Workflow directory.  It contains a series of directories, each of which implements
a step in the BPS workflow, with general order of processing indicated by the step's letter code.  
A given step may depend on data generated upstream of it.

Below are steps associated with the 1000SV workflow and their description:
* A_Project - contains most locale and project-specific information, e.g. paths to primary data, sample IDs
* B_CTX, C_Pindel, ... - Various SV predictions and other evidence based on primary data.  Independent of PlotList
* G_PlotList - Defines regions of interest / plot ranges based on upstream discovery
* H_ReadDepth, ... - PlotList-driven analyses of primary data
* M_Reference - Reference-specific and other static data not specific to project.  Data
    for selected reference distributed with project.  Optional.
* N_RenderBreakpoint, O_RenderDepth, P_RenderAnnotation, Q_RenderHistogram - Create GGP objects
    which correspond to particular panels in combined BPS plot.  These and sebsequent steps 
    rely only on secondary data generated in steps B-M.
* W_AssembleBPS - Create composite BreakpointSurveyor PDF figure based on GGP objects.


bps.config is defined differently for each repository.  To keep it from being updated, do
    git update-index --assume-unchanged bps.config
