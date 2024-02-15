#!/bin/bash

## Create Project
PRJ[0]="integration-demo"

for i in "${PRJ[@]}"
do
    if [ "$(oc get project $i)" ]; then
        echo  "$i already exists..."
    else
        oc new-project $i
    fi
done

sleep 5

# Delete Limitrange
oc delete limitrange ${PRJ[0]}-core-resource-limits -n ${PRJ[0]}

sleep 5

## Operator Install
# AMQ Streams
    if [ "$(oc -n openshift-operators get subscription amq-streams)" ] ; then
        echo "Red Hat AMQ Streams already exists..."
    else
        oc apply -f ./openshift/kafka/amq-streams-operator.yaml
    fi

# Camel K Operator
#    if [ "$(oc -n ${PRJ[0]} get subscription camel-k)" ] ; then
#        echo "Camel K Operator already exists..."
#    else
#        oc apply -f ./openshift/camel-k/camel-k-operator.yaml
#ß    fi  
    
sleep 30

## Kafka Deploy
# Kafka-Cluster Deploy
    if [ "$(oc get kafka -n ${PRJ[0]} s3-cluster)" ] ; then
        echo "kafka-cluster already exists..."
    else
        oc apply -n ${PRJ[0]} -f ./openshift/kafka/kafka-s3.yaml
    fi

Sleep 15

# Kafka Topic Create
oc apply -n ${PRJ[0]} -f ./openshift/kafka/kafkatopic-create.yaml

Sleep 15

#install kafka tools
#helm install kafka-ui charts/kafka-ui -f ./charts/kafka-ui/values.yaml
#helm install kafdrop . -f values.yaml --set hostname=s3-cluster-kafka-bootstrap.integration-demo.svc:9092 -n ${PRJ[0]}