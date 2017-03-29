DIR=$1

function run_stage {
    DIR=$1
    pushd $DIR

        CONFIG="BPS_Stage.config"
        if ! [ -f $CONFIG ]; then
            echo $DIR/$CONFIG does not exist! Exiting.
        fi

        source ./$CONFIG
        # All steps are now specified in $STEPS
        
        for step in $STEPS; do
            echo running $step
        done

    popd
}

if [ -z $DIR ]; then
    echo Target is not specified.  Exiting.
    exit
fi

if ! [ -d $DIR ]; then
    echo Target $DIR unknown.  Exiting.
    exit
fi

echo Processing $DIR
run_stage $DIR

