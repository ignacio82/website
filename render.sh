#!/bin/bash

docker build --tag resume .

docker run --rm \
    --user $UID:$(id -g) \
    -v $(pwd):/tmp/working_dir \
    -w /tmp/working_dir \
    resume \
    R -e "rmarkdown::render('Ignacio Martinez CV.Rmd')"
