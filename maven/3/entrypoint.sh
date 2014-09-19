#!/bin/bash

if [ -x $1 ]; then
  exec "$@"
else
  exec mvn "$@"
fi

