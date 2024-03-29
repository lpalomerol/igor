function createRscriptFile() {
    FILE_NAME=$1

    SCRIPT_NAME=$(echo "$FILE_NAME" | sed "s/\\.Rmd$//i").Rmd

    echo '---
title: ""
author: "'$IGOR_AUTHOR'"
date: "`r format(Sys.time(), '"'"'%d %B, %Y'"'"')`"
output:
  bookdown::word_document2: default    
  bookdown::pdf_document2: default  
  bookdown::html_document2: 
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

```{r describe_params}

t(data.frame(params))

```

# Introduction

# Data preprocessing

```{r deps}

library(knitr)
library(dplyr)
library(foreach)

opts_chunk$set(dev=c("png","postscript"))

```

## Loading Data

```{r data_load}

```

# Conclusion

# Session

```{r session}

sessionInfo()

```


' > $SCRIPT_NAME

echo $SCRIPT_NAME

}
