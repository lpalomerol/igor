HERE=$(pwd)

function createRscriptFile() {
    FILE_NAME=$1

    SCRIPT_NAME=$(echo "$FILE_NAME" | sed "s/\\.Rmd$//i").Rmd

    echo '---
title: ""
author: "'$IGOR_AUTHOR'"
date: "`r format(Sys.time(), '"'"'%d %B, %Y'"'"')`"
output:
  html_document:
    self_contained: yes
    toc: true
    theme: united
params:
  foo: "bar"
---

```{r params, echo=FALSE}

if(exists('"'"'params'"'"')==FALSE){
  rm( list = ls() )  
  params = data.frame(
    stringsAsFactors = FALSE
  )
}

```

## Introduction

## Data preprocessing

```{r deps}

suppressMessages(library(knitr))
suppressMessages(library(dplyr))
suppressMessages(library(foreach))

#suppressWarnings(suppressMessages(library(survival)))

opts_chunk$set(dev=c("png","postscript"))

```

### Loading Data

```{r data_load}

```

## Conclusion

' > $SCRIPT_NAME

echo $SCRIPT_NAME

}
