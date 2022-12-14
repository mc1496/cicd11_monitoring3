#!/bin/bash

#access_key: EC2_RO_ACCESS_KEY
#secret_key: EC2_RO_SECRET_KEY

YML=./roles/prometheus/files/prometheus.yml
if [[ $1 = set ]];then
    echo "set secret-values from env-var to $YML"
    sed -i "s/EC2_RO_ACCESS_KEY/${EC2_RO_ACCESS_KEY}/g" $YML
    sed -i "s#EC2_RO_SECRET_KEY#$EC2_RO_SECRET_KEY#g" $YML
elif [[ $1 = clear ]];then
    echo "clear secret values from $YML"
    sed -i "s/access_key.*/access_key: EC2_RO_ACCESS_KEY/" $YML
    sed -i "s/secret_key.*/secret_key: EC2_RO_SECRET_KEY/" $YML
else
    echo "set or clear required as one mandatory arg"
fi