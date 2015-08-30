#!/bin/sh

PORT=${PORT:=4567}

function run {
  if [ $# -eq 2 ]; then
    value=`ruby -ruri -e "puts URI.escape('$2')"`
    cmd="$1 | curl -s -XPOST --data-binary @- 'http://localhost:$PORT/?with_input=true&command=$value'"
  else
    cmd="curl -s -F 'command=$1' http://localhost:$PORT/"
  fi
  echo ------------------------
  echo $cmd
  echo ------------------------
  eval $cmd
  echo "\n\n"
}

#run "ls"
#run "ls -l"
run "cat Gemfile" "grep gem"

