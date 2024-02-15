#!/bin/bash
#

## Create Project
PRJ[0]="integration-demo"

for i in "${PRJ[@]}"
do
  oc delete project $i
done
