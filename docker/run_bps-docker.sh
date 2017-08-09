
# host data directory is where BPS data will be written.
HOST_DATA="$PWD/data"
mkdir -p $HOST_DATA

docker run -v $HOST_DATA:/data -it mwyczalkowski/breakpoint_surveyor:latest
