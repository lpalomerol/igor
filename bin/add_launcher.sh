HERE=$(dirname `realpath $0`)

source $HERE/bin/tools/cleaners.sh
source $HERE/bin/tools/dialogs.sh



function add_launcher(){
    local LAUNCHER_NAME=$1
    local EXPERIMENT_NAME=${2:-'./runall.sh'}

    update_exp_code `cleanInput $LAUNCHER_NAME` `cleanInput $EXPERIMENT_NAME`
    say "Updated experiment file located at $EXPERIMENT_NAME - added launcher $LAUNCHER_NAME"
}


function update_exp_code(){
    local LAUNCHER_NAME=$1
    local EXPERIMENT_NAME=$2

    local LAUNCHER_METHOD=$(basename $LAUNCHER_NAME | sed 's/.sh$//')
    local LAUNCHER_SCAPE=`escapeBackslashes $LAUNCHER_NAME`

    local LAUNCHER_SNIPPET='\
STEP_ID=X \
\
say "[STEP $STEP_ID]: Executing '$LAUNCHER_METHOD'" \
\
response=$(ask "Do you want to execute '$LAUNCHER_METHOD'?")\
\
if [[ $response =~ ^(yes|y)$ ]]; then \
  say "Launching '$LAUNCHER_METHOD'"\
  '$LAUNCHER_METHOD' \\\
    $(newFolder $RESULTS_FLDR\/$STEP_ID.'$LAUNCHER_METHOD') \\\
    $RESULTS_FLDR\/$STEP_ID.'$LAUNCHER_METHOD'.html \
else \
  say "Skip launching '$LAUNCHER_METHOD'"\
fi\
\
\'

    sed -i 'H;s/#Bash launchers/&\nsource '$LAUNCHER_SCAPE'/' $EXPERIMENT_NAME
    sed -i "H;s/#End of experiments/$LAUNCHER_SNIPPET &/"  $EXPERIMENT_NAME


}
