#!/bin/sh

PORT=${PORT:=4567}

function run {
  url=http://localhost:$PORT

  if [ $# -eq 2 ]; then
    value=`ruby -rcgi -e "puts CGI.escape('$2')"`
    cmd="$1 | curl -s -XPOST --data-binary @- '$url?with_input=true&command=$value'"
  else
    cmd="curl -s -F 'command=$1' $url"
  fi

  echo ------------------------
  echo $cmd
  echo ------------------------
  eval $cmd
  echo "\n\n"
}

function run_coffee {
  url=http://localhost:$PORT/coffee

  if [ $# -eq 2 ]; then
    value=`ruby -rcgi -e "puts CGI.escape('$2')"`
    cmd="$1 | curl -s -XPOST --data-binary @- '$url?with_input=true&args=$value'"
  else
    cmd="curl -s -F 'args=$1' $url"
  fi

  echo ------------------------
  echo $cmd
  echo ------------------------
  eval $cmd
  echo "\n\n"
}

#run "ls"
#run "ls -l"
#run "cat Gemfile" "grep gem"
#run "cat test/test.coffee test/test1.coffee" "coffee -c -s"

#run_coffee "-v"
#run_coffee "cat test/test.coffee" "-c -s"
#run_coffee "cat test/test.coffee test/test1.coffee" "-c -s"

# ;&<` is not accepted
#run_coffee "-v; ls"
#run_coffee "cat test/test.coffee test/test1.coffee" "-c -s; ls"

