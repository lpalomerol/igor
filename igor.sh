#!/bin/bash

function version(){
  echo "Igor version 0.0.1"
}

function usage(){
  echo "$(basename $0) [-h] -- Igor suite, help tool to manage R-bash projects
    where
      -h  show this help
  "
}


# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -o hv -l help,version -- "$@")
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
    # for options with required arguments, an additional shift is required
#    -c|--clong) cargument="$2" ; shift;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    (*) break;;
    esac
    shift
done
