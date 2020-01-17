HERE=$(dirname `realpath $0`)

source $HERE/bin/tools/notebook.sh
source $HERE/bin/tools/git.sh
source $HERE/bin/tools/dialogs.sh


source $HERE/bin/createClient.sh
source $HERE/bin/createExperiment.sh
source $HERE/bin/createProject.sh
source $HERE/bin/createRscriptFile.sh


function create(){

    local QUERY=$(echo $1 | sed "s/'//g")
    local TITLE=$(echo $2 | sed "s/'//g")
    case $QUERY in
	client)
	    say "Creating client $TITLE"
	    createClient $TITLE
	    ;;
	project)
	    say "Creating project $TITLE"
	    FOLDER=$(createProject "." $TITLE)
	    GIT_PATH=`echo $(inGit $FOLDER)`
	    if $(echo $GIT_PATH | grep -q "git"); then
		git add $FOLDER
		say "Base folder structure created at $FOLDER (and added to GIT)"
	    else
		say "Base folder structure created at $FOLDER"
	    fi
	    ;;
	rmd)
	    say "Creating Rscript file from $TITLE"
	    FILENAME=$(createRscriptFile $TITLE)
	    #ONLY WORKS ON "BIN" DIRECTORY
	    toNotebook "'Creating $FILENAME at ["$(pwd)"]'" ../results/notebook.html
	    if $(echo `echo $(inGit $pwd)` | grep -q "git"); then
		git add $FILENAME
		say "Created $FILENAME Rmd script (and added to GIT)"
	    else
		say "Created $FILENAME Rmd script"
	    fi
	    ;;
	exp)
	    say "Creating Experiment pipeline named $TITLE"
	    EXP_NAME=$(createExperiment $TITLE)
	    echo $EXP_NAME
	    if $(echo `echo $(inGit $pwd)` | grep -q "git"); then
		local EXP_FOLDER=`basename $EXP_NAME`
		echo "*" > $EXP_FOLDER/.gitignore
		echo "!runall.sh" >> $EXP_FOLDER/.gitignore
		git add -f $EXP_NAME
				 
		say "Created $EXP_NAME experiment folder (and added to GIT)"
	    else
		say "Created $EXP_NAME experiment folder"
	    fi

	    ;;	    
    esac

}
