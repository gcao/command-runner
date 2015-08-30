#!/bin/sh

PORT=${PORT:=4567}

echo ------------------------
echo Testing ls
echo ------------------------
curl -s -F 'command=ls' http://localhost:$PORT/

echo "\n\n------------------------"
echo Testing ls -l
echo ------------------------
curl -s -F 'command=ls -l' http://localhost:$PORT/

