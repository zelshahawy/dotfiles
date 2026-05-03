#!/bin/zsh

if [[ $# -ne 1 ]]; then
  echo "Wrong argument count, only one expected"
  exit 1
else
  git add modules
  git commit -m "Updated $1"
  git push origin
fi
