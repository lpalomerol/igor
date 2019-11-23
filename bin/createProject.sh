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

  echo "Creating doc folder"
  mkdir -p $FOLDER/doc

  echo "Creating data folder"
  mkdir -p $FOLDER/data

  echo "Creating src folder structure"
  mkdir -p $FOLDER/src
  mkdir -p $FOLDER/src/sh
  mkdir -p $FOLDER/src/r

#  cp $PTP/lib/loaders/loadRData.R $FOLDER/src/r
#  cp $PTP/lib/formatters/formatTcgaBarcode.R $FOLDER/src/r

  echo "Creating bin folder"
  mkdir -p $FOLDER/bin

  echo "Creating results folder"
  mkdir -p $FOLDER/results

  TODAY=`DATE +%Y-%m-%d`
  echo "<meta http-equiv=\"content-type\" content=\"text/html\"; charset=\"utf-8\">
  <h1>$TODAY</h1>
  <b>$TODAY</b> [AUTO]: Creating project $FOLDER
  <br>" > $FOLDER/results/notebook.html

#  git add $FOLDER

  echo "Base folder structure created at $FOLDER (and added to GIT)"
}
