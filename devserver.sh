#!/bin/sh
alias server="cd ./server && ./run.sh"
alias client="cd ./client && grunt serve"

server & client
