#!/bin/bash

IGOR_PATH=`dirname $(realpath $0)`

source $IGOR_PATH/.env

source $IGOR_PATH/bin/create.sh
source $IGOR_PATH/bin/launcher.sh

function version(){
  echo "Igor version 0.0.1"
}

function usage(){
  echo "$(basename $0) [-h] -- Igor suite, help tool to manage R-bash projects
    where
      -h --help show this help
      -c --create Creates something: samples
         client: Creates a client folder structure in current location
         project: Creates a project in current location
         rmd: Creates a Rmd file in current in current location
	 exp: Creates a new experiment in cuurrent locationn
      -l --launcher Builds a launcher snippet
  "
}

# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -o hvcl -l help,version,create,launcher -- "$@")
then
    # something went wrong, getopt will put out an error message for us
    exit 1
fi

set -- $options

while [ $# -gt 0 ]
do
    case $1 in
    -h|--help) usage ;;
    -v|--version) version ;;
    -c|--create) create $3 $4;;
    -l|--launcher) launcher $3 $4;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $2" 1>&2; exit 1;;
    (*) break;;
    esac
    shift
done


