#!/usr/bin/env bash

ecr-login() {
    if ! command -v aws > /dev/null ;
    then
        echo 'ERROR: aws cli is not installed'
        return 1
    fi

    $(aws ecr get-login --no-include-email)
}
