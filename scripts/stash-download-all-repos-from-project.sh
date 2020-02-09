#!/usr/bin/env bash

stash-download-all-repos-from-project() {

  if test -z "$1" ; then
      echo 'Please provide as FIRST parameter the Stash URL (e.g. https://stash.contoso.com)' ;
      return 1 ;
    else 
      STASH_URL=$1
  fi

  if test -z "$2" ; then
      echo 'Please provide as SECOND parameter the Stash Cookie (e.g. BITBUCKETSESSIONID=1234)' ;
      return 1 ;
    else 
      COOKIE=$2
  fi

  if test -z "$3" ; then
      echo 'Please provide as THIRD parameter the Stash Project name (e.g. CICD)' ;
      return 1 ;
    else
      PROJECT_NAME=$3
  fi

  for SSH_URL in $(\
      curl "${STASH_URL}/rest/api/1.0/projects/${PROJECT_NAME}/repos?limit=999999" \
          -H "Cookie: ${COOKIE}" | \
      jq '.values[].links.clone[] | select (.name | contains("ssh")) | .href ' -r \
  ) ; do 
      git clone ${SSH_URL} &
  done
}
