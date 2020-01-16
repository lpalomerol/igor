HERE=$(dirname `realpath $0`)

source $HERE/bin/notebook.sh
source $HERE/bin/git.sh

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
	FOLDER=$(createProject "." $TITLE)
	GIT_PATH=`echo $(inGit $FOLDER)`
	if $(echo $GIT_PATH | grep -q "git"); then
	    git add $FOLDER
	    echo "Base folder structure created at $FOLDER (and added to GIT)"
	else
	    echo "Base folder structure created at $FOLDER"
	fi
      ;;
    rmd)
	FILENAME=$(createRscriptFile $TITLE)
	echo $FILENAME
	#ONLY WORKS ON "BIN" DIRECTORY
	toNotebook "'Creating $FILENAME at ["$(pwd)"]'" ../results/notebook.html
	echo "author is $IGOR_AUTHOR"
	if $(echo `echo $(inGit $pwd)` | grep -q "git"); then
	    git add $FILENAME
	    echo "Created $FILENAME Rmd script (and added to GIT)"
	else
	    echo "Created $FILENAME Rmd script"
	fi					  
  esac

}
