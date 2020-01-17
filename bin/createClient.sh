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
