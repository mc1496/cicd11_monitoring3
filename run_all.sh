#!/bin/bash

ENV="XAM"
###############################################################################
STK1="xam-ec2-mon"
INV1="./inventory-ec2-prometheus.txt"
###############################################################################
STK2="xam-ec2-nodex1"
INV2="./inventory-ec2-node-exporter.txt"
###############################################################################

if [[ $1 = set ]];then
    echo "SET/BUILD/CREATE All"
    echo "************************************************"
    ./set_ec2_ro_keys.sh clear
    ./set_alertmanager_emails_info.sh clear
    #-----
    ./set_ec2_ro_keys.sh set
    ./set_alertmanager_emails_info.sh set
    ###############################################################################
    ./deploy.sh $STK1 ec2-prometheus.yml ec2-prometheus.json $ENV
    ###
    DNS1=`aws cloudformation list-exports \
    --query "Exports[?Name=='$ENV-EC2PublicDnsName-Prometheus'].Value" \
    --output text`
    echo "[all]" > $INV1
    echo $DNS1 >> $INV1
    tail $INV1
    ###############################################################################
    ./deploy.sh $STK2 ec2-node-exporter.yml ec2-node-exporter.json $ENV
    ###
    DNS2=`aws cloudformation list-exports \
    --query "Exports[?Name=='$ENV-EC2PublicDnsName-NodeExporter'].Value" \
    --output text`
    echo "[nodeX]" > $INV2
    echo $DNS1 >> $INV2
    echo $DNS2 >> $INV2
    tail $INV2
    ###############################################################################
    ansible-playbook -i $INV2 ansible-ec2-node-exporter.yml --private-key=xam-ec2-key-cicd.pem
    ###############################################################################
    ansible-playbook -i $INV1 ansible-ec2-prometheus.yml --private-key=xam-ec2-key-cicd.pem
    ###############################################################################
    ##
    ###############################################################################
elif [[ $1 = clear ]];then
    echo "CLEAR/DESTROY All"
    echo "************************************************"
    ./set_ec2_ro_keys.sh clear
    ./set_alertmanager_emails_info.sh clear
    ###############################################################################
    ./delete.sh $STK1
    ./delete.sh $STK2
else
    echo "************************************************"
    echo "set or clear required as one mandatory arg"
    echo "************************************************"
fi
