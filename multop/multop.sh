#!/usr/bin/env bash

if [ -z ${1} ]
   then
       echo "Usage :  multop [process name]"
       exit 0
   else
       pids=$(ps aux |grep $1 |awk {'print$2'})
       foo=$(for i in ${pids[@]}; do echo "-p $i"; done)
       htop_args=$(printf '%s\s' "${foo}" | tr '\n' ' ')
       htop $htop_args
fi
