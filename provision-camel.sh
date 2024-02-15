#!/bin/bash

## Create Project
PRJ[0]="integration-demo"

sleep 5

kamel delete s3

## Camel K Integration Deploy
kamel run -d camel:aws2-s3 -d camel:kafka ./openshift/camel-k/s3.camel.yaml --config configmap:s3-config
