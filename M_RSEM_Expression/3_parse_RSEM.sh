# Process TCGA RSEM data to
# * retain only regions of interest as defined by BED file
# * process first column of RSEM data to expand into columns chrom, start, end, gene
#   with gene obtained from gene BED file (created in step 2)
#   We need to do this because the RSEM data does not define exons.  We use only position and not strand
#   information for this assignment, which may result in mis-identification of which gene a given domain 
#   belongs to.
# * Also generate a BED file with exon stream information; this exons file is necessary only
#   to make workflow be analogous to that in L_Expression

# For all samples with detected breakpoints, extract lines of RSEM exon file from 
# region around breakpoints.
# This processing is very specific to TCGA RSEM data format
# We extract only the exon name and RSEM value columns.
# Samples which have already been processed will be skipped.


source ./BPS_Stage.config

# Enable process substitution, used in tee >() 
set +o posix

# for safety against overwriting existing data set this to 0
OVERWRITE_OUTPUT=1

# add optional chromosome renaming here
BIN="$BPS_CORE/src/analysis/RSEM_reader.py"

BEDD="$OUTD/BED"
mkdir -p $BEDD

function process {
    CHROM_ID=$1
    NAME=$2
    DAT=$3

    DATA_OUT="$OUTD/${NAME}.${CHROM_ID}.RSEM.dat"
    EXON_OUT="$BEDD/${NAME}.${CHROM_ID}.exons.bed"
    BED="$BEDD/${NAME}.${CHROM_ID}.genes.bed"

    # Keep only the "RSEM" columns as well as the first column.  
    # very specific to format of RSEM data
    NCOL=`tar -zxOf $DAT | grep -v "exon_quantification__data.data.txt" | head -n1 | tr '\t' '\n' | wc -l`
    SEQ=`seq 4 3 $NCOL`  # 4 7 10
    SEQ2=`echo $SEQ | tr ' ' ','`  # 4,7,10

    if [[ -e $DATA_OUT ]]; then
        if [ $OVERWRITE_OUTPUT == 0 ]; then
            echo "$DATA_OUT exists.  Skipping."
            continue
        fi
    fi
    echo "Reading $DAT, writing $NAME data to $DATA_OUT and $EXON_OUT"

    # Read and process the RSEM file, which is in .tar.gz format.  Multiple steps as follows:
    #   * Stream .tar.gz to stdout
    #   * There is a file in the tar.gz named exon_quantification__data.data.txt.  Ignore this in stream
    #   * Extract columns of interest given by SEQ2
    #   * Use `tee` together with process substitution to send data to two processes simultaneously
    #       * process 1 calls RSEM_reader.py to extract exons of interest from RSEM data, retaining strand information; insert empty column 5 and write to $EXON_OUT
    #       * process 2 also calls RSEM_reader.py, expanding column 1 and retaining the data
    #       * stdout is discarded
    #       * Tee command background: http://unix.stackexchange.com/questions/28503/how-can-i-send-stdout-to-multiple-commands
    #       * `tee` is used for performance reasons, so that the large data file need not be read twice
    #           * If there are issues with this step, can simply do this in two steps

    # We create two outputs, EXON_OUT and DATA_OUT, to make the workflow here analogous to that in L_Expression

    # Usage: RSEM_reader.py [options] regions.bed
    # -i infn:  Input data filename
    # -o outfn:  Output data filename
    # -d  Turn on debugging
    # -c  Convert first column of RSEM data into columns [chr, start, end, gene]
    # -p  Add strand information to leading columns.  Implies -c
    # -D  Exclude data columns, write only leading columns.
    # -H  Do not write header
    # -s N:  Remove N leading characters in chrom name

    # using -s 3 to remove leading 'chr' from chrom names  

    tar -zxOf $DAT | grep -v "exon_quantification__data.data.txt" | cut -f "1,$SEQ2" | tee >(python $BIN -s 3 -p -H -D $BED | awk 'BEGIN{FS="\t";OFS="\t"}{print $1,$2,$3,$4,".",$5}' > $EXON_OUT) >(python $BIN -s 3 -c -o $DATA_OUT $BED) 1> /dev/null

    # Equivalent
    # tar -zxOf $DAT | grep -v "exon_quantification__data.data.txt" | cut -f "1,$SEQ2" | python $BIN -s 3 -c -o $DATA_OUT $BED 
    # tar -zxOf $DAT | grep -v "exon_quantification__data.data.txt" | cut -f "1,$SEQ2" | python $BIN -s 3 -p -H -D $BED | awk 'BEGIN{FS="\t";OFS="\t"}{print $1,$2,$3,$4,".",$5}' > $EXON_OUT


    echo Written to $DATA_OUT and $EXON_OUT

}

while read l; do
# barcode name    chrom.A event.A.start   event.A.end range.A.start   range.A.end chrom.B event.B.start   event.B.end range.B.start   range.B.end
# TCGA-IS-A3KA-01A-11D-A21Q-09    TCGA-IS-A3KA-01A-11D-A21Q-09.chr_1_2.aa 1   5156542 207193935   5106542 207243935   2   122476446   228566993   122426446   228616993
 
    # Skip comments and header
    [[ $l = \#* ]] && continue  
    [[ $l = barcode* ]] && continue

    #TCGA-CV-5443-01A-01D-2268-08    HNSC    HPV16   9   5387648 5465103

    NAME=`echo "$l" | cut -f 2`
    DAT="dat.untracked/HNSC.RSEM.tar.gz"

    if [ $FLIPAB == 1 ]; then  # see ../bps.config
        CHROM_ID=B
    else
        CHROM_ID=A
    fi

    process $CHROM_ID $NAME $DAT 

done < $PLOT_LIST
