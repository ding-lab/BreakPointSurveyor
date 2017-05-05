source ./BPS_Stage.config

# Create PlotList.dat by commenting out all events in PlotList-prelim.dat except those with events AQ and AU
# In the general case, simply copy PlotList-prelim.dat to PlotList.dat and edit by hand as appropriate

DAT="$OUTD/PlotList-prelim.dat"

sed -e '/AQ\|AU\|barcode/b; s/^#*/#/' $DAT > $PLOT_LIST

echo Written to $PLOT_LIST
