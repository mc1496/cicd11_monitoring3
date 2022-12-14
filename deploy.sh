#!/bin/bash

if [ ! "$4" ]; then
    echo -e "WARNING: NO EnvironmentName-Value is provided \n"
    #ENVAL="XAMYXAR"
else
    sed -i "/EnvironmentName/{n;s/.*/\t\t\"ParameterValue\": \"$4\"/}" $3
fi

######################################################################
echo "deploying the stack: $1"
######################################################################
aws cloudformation deploy \
--stack-name $1 \
--template-file $2 \
--parameter-overrides file://$3 \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=us-east-1
######################################################################
# echo "WAIT..."
# aws cloudformation wait stack-create-complete --stack-name $1
# echo "$1 stack is created."
######################################################################
aws cloudformation list-exports