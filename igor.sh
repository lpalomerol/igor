#!/bin/bash

HERE=$(dirname $0)

source $HERE/bin/create.sh

function version(){
  echo "Igor version 0.0.1"
}

function usage(){
  echo "$(basename $0) [-h] -- Igor suite, help tool to manage R-bash projects
    where
      -h --help show this help
      -c --create Creates something: samples
         client: Creates a create
         project: Creates a project
  "
}


# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -o hvc -l help,version,create -- "$@")
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
    # for options with required arguments, an additional shift is required
#    -c|--clong) cargument="$2" ; shift;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $2" 1>&2; exit 1;;
    (*) break;;
    esac
    shift
done
