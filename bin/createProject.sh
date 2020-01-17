#!/usr/bin/env bash

function createProject(){

  GROUP=$1
  PROJECT_LABEL=$2
  TODAY=`date +%Y%m%d`

  PROJECT_NAME=$TODAY'.'$PROJECT_LABEL

  FOLDER=$GROUP/$PROJECT_NAME

  if [ ! -d "$FOLDER" ]; then
    mkdir -p $FOLDER
  else
    echo "ERROR $FOLDER exists"
    exit -1
  fi

  mkdir -p $FOLDER/doc

  mkdir -p $FOLDER/data

  mkdir -p $FOLDER/src
  mkdir -p $FOLDER/src/sh
  mkdir -p $FOLDER/src/r

  mkdir -p $FOLDER/bin

  mkdir -p $FOLDER/results

  TODAY=`date +%Y-%m-%d`
  echo "<meta http-equiv=\"content-type\" content=\"text/html\"; charset=\"utf-8\">
  <h1>$TODAY</h1>
  <b>$TODAY</b> [AUTO]: Creating project $FOLDER
  <br>" > $FOLDER/results/notebook.html

  echo $FOLDER
}
