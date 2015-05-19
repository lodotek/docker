#!/bin/bash

if [ -x "$(which $1)" ]; then
  exec "$@"
else
  exec mvn "$@"
fi

