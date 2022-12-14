#!/bin/bash

# - to: GMAIL_ADDRESS
#     from: GMAIL_APP_ID
#     smarthost: smtp.gmail.com:587
#     auth_username: GMAIL_APP_ID
#     auth_identity: GMAIL_APP_ID
#     auth_password: GMAIL_APP_PASS

YML=./roles/alertmanager/files/alertmanager.yml
if [[ $1 = set ]];then
    echo "set email-info-values from env-var to $YML"
    sed -i "s#GMAIL_ADDRESS#$GMAIL_ADDRESS#g" $YML
    sed -i "s#GMAIL_APP_ID#$GMAIL_APP_ID#g" $YML
    sed -i "s#GMAIL_APP_PASS#$GMAIL_APP_PASS#g" $YML
elif [[ $1 = clear ]];then
    echo "clear email-info values from $YML"
    sed -i "s/- to:.*/- to: GMAIL_ADDRESS/" $YML
    sed -i "s/from:.*/from: GMAIL_APP_ID/" $YML
    sed -i "s/auth_username:.*/auth_username: GMAIL_APP_ID/" $YML
    sed -i "s/auth_identity:.*/auth_identity: GMAIL_APP_ID/" $YML
    sed -i "s/auth_password:.*/auth_password: GMAIL_APP_PASS/" $YML
else
    echo "set or clear required as one mandatory arg"
fi
tail -n 8 $YML