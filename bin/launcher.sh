HERE=$(dirname `realpath $0`)

source $HERE/bin/tools/cleaners.sh
source $HERE/bin/tools/dialogs.sh

function getDuplicatedChunks(){
  local RSCRIPT_FILE=$1
  echo $(grep "{r" $RSCRIPT_FILE | sort | uniq  -c | grep  -v ' 1 ')
}

function countDuplicatedChunks(){
  local RSCRIPT_FILE=$1
  echo $(grep "{r" $RSCRIPT_FILE | sort | uniq  -c | grep  -v ' 1 ' |  wc -l)
}

function countFooBar(){
  local RSCRIPT_FILE=$1
  echo $(grep 'foo: "bar"' $RSCRIPT_FILE | wc -l)
}

function createShLauncher(){
    local ORIGINAL_SCRIPT=$1
    local RSCRIPT_PATH=${2:-'../src/sh'}

    local RSCRIPT_NAME=$(basename ${ORIGINAL_SCRIPT})
    local RSCRIPT_NAME=$(echo "$RSCRIPT_NAME"| sed  's/.Rmd//')
    local COMPLETE_RSCRIPT_PATH="$RSCRIPT_PATH/do${RSCRIPT_NAME^}.sh"
    local  DUPLICATED_CHUNKS=$(countDuplicatedChunks $ORIGINAL_SCRIPT)

    if [ "$DUPLICATED_CHUNKS" -gt "0" ]; then
	err "There are duplicated chunks at $ORIGINAL_SCRIPT:"
	err $(getDuplicatedChunks $ORIGINAL_SCRIPT) 
	exit -1
    fi

    local FOO_BAR_FOUND=$(countFooBar $ORIGINAL_SCRIPT)

    if [ "$FOO_BAR_FOUND" -gt "0" ]; then
	err "FOO_BAR keyword found at $ORIGINAL_SCRIPT, sould be removed!"
	exit -1
    fi

    local  PARAMS_LINE=$(awk '{if ($0 == "params:" ){print NR}}' $ORIGINAL_SCRIPT)

    local END_PARAMS_LINE=$(awk '{if ($0 == "---" && NR > '$PARAMS_LINE' ){print NR}}' $ORIGINAL_SCRIPT)
    local OUTPUT_HTML_PARAM=$(expr $END_PARAMS_LINE - $PARAMS_LINE)

    LINES=$(awk 'BEGIN{FS=":";par=1}
{if (NR > '$PARAMS_LINE'  && NR < '$END_PARAMS_LINE') {
  print $1"=\x27$"par"\x27"; if(NR < '$END_PARAMS_LINE' -1){ print ","};
  par++ }
} ' $ORIGINAL_SCRIPT)

    echo 'function do'${RSCRIPT_NAME^}'() {
  local RSCRIPT="'$RSCRIPT_NAME'.Rmd"

  local OUTPUT_HTML=$'$OUTPUT_HTML_PARAM'

  echo Rscript -e "library(knitr);rmarkdown::render('"'"'$RSCRIPT'"'"', params=list(\
              '$LINES'\
              ), output_file='"'"'$OUTPUT_HTML'"'"', encoding='"'"'UTF-8'"'"')"

  Rscript -e "library(knitr);rmarkdown::render('"'"'$RSCRIPT'"'"', params=list(\
              '$LINES'\
              ), output_file='"'"'$OUTPUT_HTML'"'"', encoding='"'"'UTF-8'"'"')"
}
' > $COMPLETE_RSCRIPT_PATH
    echo $COMPLETE_RSCRIPT_PATH
}




function launcher() {
   local LAUNCHER_FILE=$(createShLauncher `cleanInput $1` `cleanInput $2`)
   if $(echo `echo $(inGit $pwd)` | grep -q "git"); then
       git add $LAUNCHER_FILE
       say "Created launcher at $LAUNCHER_FILE (and adding it to GIT)"
   else
       say "Created launcher at $LAUNCHER_FILE"       
   fi

}



#git add $COMPLETE_RSCRIPT_PATH
#say "Script $RSCRIPT_NAME created successfully at $RSCRIPT_PATH"
