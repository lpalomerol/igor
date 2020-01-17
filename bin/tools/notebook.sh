function newLog(){
    local PREFIX=$1
    local INPUT_TEXT=$2
    TODAY=`date +%Y-%m-%d`

    echo "<b>$TODAY</b>[$PREFIX] $INPUT_TEXT
<br>"

}

function toNotebook(){
    local NOTEBOOK_TEXT=$1
    local NOTEBOOK_PATH=$2
    if [ -f $NOTEBOOK_PATH ]; then
	echo $(newLog "AUTO" "'$NOTEBOOK_TEXT'") >> $NOTEBOOK_PATH
    else
	warn "No $NOTEBOOK_PATH found"
    fi
}
