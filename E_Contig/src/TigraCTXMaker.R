# Matthew Wyczalkowski
# mwyczalk@genome.wustl.edu
#
# Usage: Rscript TigraCTXMaker.R [-v] Pindel_RP out.ctx

# Create a breakdancer-style CTX file from Pindel _RP to be used as tigra-sv input
# Note that this is heuristic - guessing for a lot of fields.

library("reshape2")
library("plyr")
#library("ggplot2")

options("width"=300) 

get_val_arg = function(args, flag, default) {
    ix = pmatch(flag, args)
    if (!is.na(ix)){ val = args[ix+1] } else { val = default }
    return(val)
}

get_bool_arg = function(args, flag) {
    ix = pmatch(flag, args)
    if (!is.na(ix)){ val = TRUE } else { val = FALSE }
    return(val)
}

parse_args = function() {
    args = commandArgs(trailingOnly = TRUE)

    # optional arguments
    verbose = get_bool_arg(args, "-v")

    # mandatory positional arguments.  These are popped off the back of the array, last one listed first.
    out.ctx.fn = args[length(args)];            args = args[-length(args)]
    pindel.rp.fn = args[length(args)];          args = args[-length(args)]

    val = list( 'verbose'=verbose, 'out.ctx.fn'=out.ctx.fn, 'pindel.rp.fn'=pindel.rp.fn)
    if (val$verbose) { print(val) }

    return (val)
}

args = parse_args()

pindel.rp = read.table(args$pindel.rp.fn, sep="\t", row.names=NULL, header=FALSE, col.names=c("A.NAME", "A.START", "A.STOP", "A.STRAND", "A.LENGTH", "B.NAME", "B.START", "B.STOP", "B.STRAND", "B.LENGTH", "BP.LENGTH", "SUPPORT"))
# A.NAME A.START A.STOP A.STRAND A.LENGTH                        B.NAME  B.START   B.STOP B.STRAND B.LENGTH BP.LENGTH      SUPPORT
# 1 gi|310698439|ref|NC_001526.2|    1771   2872        -     1101 gi|310698439|ref|NC_001526.2|     7061     8162        +     1101      5290 Support: 724

# ctx.data will have pindel lines where A.NAME is a virus and B.NAME is not.
#ctx.data = pindel.rp[grepl("^gi",pindel.rp$A.NAME) && !grepl("^gi",pindel.rp$B.NAME),]
ctx.data = pindel.rp[grepl("^gi",pindel.rp$A.NAME) & !grepl("^gi",pindel.rp$B.NAME), c("A.NAME", "A.START", "A.STOP", "A.STRAND", "B.NAME", "B.START", "B.STOP", "B.STRAND")]

ctx.data$A.POS=round(ctx.data$A.START + (ctx.data$A.STOP - ctx.data$A.START)/2)
ctx.data$B.POS=round(ctx.data$B.START + (ctx.data$B.STOP - ctx.data$B.START)/2)

ctx.data$type = "CTX"
ctx.data$size = "-143"  # Inexplicably, all "size" fields in example BA-4077.ctx have size -143.

ctx.data = ctx.data[,c("B.NAME", "B.POS", "B.STRAND", "A.NAME", "A.POS", "A.STRAND", "type", "size")]
# Chr1   Pos1    Orientation1    Chr2    Pos2    Orientation2    Type    Size

con = file(args$out.ctx.fn, open="wt")
source = paste0("# Data source: ", args$pindel.rp.fn)
timestamp = paste0("# Created ", Sys.time())
writeLines(paste("# CTX file created by TigraCTXMaker.R", source, timestamp, sep="\n"), con)
write.table(ctx.data, con, sep="\t", quote=FALSE, row.names=FALSE, col.names=FALSE)
close(con)
cat(sprintf("    Saved to %s\n", args$out.ctx.fn))
