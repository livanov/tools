#!/usr/bin/env bash

ecr-login() {
    $(aws ecr get-login --no-include-email)
}
