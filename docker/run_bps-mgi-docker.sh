
export LSF_DOCKER_VOLUMES="/gscuser/mwyczalk/docker_data:/data"
bsub -q research-hpc -Is -a "docker(mwyczalkowski/breakpoint_surveyor:mgi)" /bin/bash -l

