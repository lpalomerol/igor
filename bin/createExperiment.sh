function createExperiment(){

    local RAW_FOLDER=$1
    local TODAY=`date +%Y%m%d`
    local EXPERIMENT_NAME=$TODAY'.'$RAW_FOLDER
    RUNALL_BASH=$EXPERIMENT_NAME/runall.sh
    mkdir -p $EXPERIMENT_NAME

    if [ -f "$RUNALL_BASH" ]; then
	err "Trying to create an existent experiment  [$RUNALL_BASH], aborting"
	exit -1
    fi

   cat ${IGOR_TEMPLATES}/runall.sh.templ > $RUNALL_BASH
   chmod u+x $RUNALL_BASH
   echo $EXPERIMENT_NAME

    
}
