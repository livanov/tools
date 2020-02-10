#!/usr/bin/env bash

alias ll="ls -alF"

if command -v kubectl > /dev/null ;
then
    source <(kubectl completion bash)
    alias k="kubectl"
    complete -F __start_kubectl k
fi

if command -v helm > /dev/null ;
then
    source <(helm completion bash)
fi

if command -v podman > /dev/null ;
then
    alias mvn='podman run --rm --volume "$(pwd)":/usr/src/project --volume "$HOME/.m2":/root/.m2 --workdir /usr/src/project maven:3-jdk-8 mvn'
else if command -v docker > /dev/null ;
    alias mvn='docker run --rm --volume "$(pwd)":/usr/src/project --volume "$HOME/.m2":/root/.m2 --workdir /usr/src/project maven:3-jdk-8 mvn'
fi

if command -v git > /dev/null ;
then
    if command -v vim > /dev/null ;
    then
        git config --global core.editor vim
    fi

    git config --global alias.la '!git config --list | grep alias | cut -c 7-'
    git config --global alias.co checkout
    git config --global alias.ci commit
    git config --global alias.st status
    git config --global alias.br branch
    git config --global alias.brn "!git rev-parse --abbrev-ref HEAD"
    git config --global alias.up '!git push -u origin $(git brn)'
    git config --global alias.down '!git pull origin $(git brn)'
    git config --global alias.fu 'reset --hard'
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.amend 'commit --amend --no-edit'
    git config --global alias.uncommit 'reset HEAD~'
    git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
fi