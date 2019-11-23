HERE=$(dirname $0)
source $HERE/bin/createProject.sh
source $HERE/bin/createRscriptFile.sh

function createClient(){
  echo "I should create client folder [$1] here"
  if [ -d "$1" ]; then
    echo "Folder $1 exists, aborting"
    exit -1
  else
    mkdir $1
    echo "Folder [$1] created"
  fi
}

function create(){

  local QUERY=$(echo $1 | sed "s/'//g")
  local TITLE=$(echo $2 | sed "s/'//g")
  case $QUERY in
    client)
      createClient $TITLE
      ;;
    project)
      createProject "." $TITLE
      ;;
    rmd)
      createRscriptFile $TITLE
  esac

}
