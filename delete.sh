#!/bin/bash

#Note this is like course supporting materials with some modifications
######################################################################
echo "deleting stack: $1"
######################################################################
aws cloudformation delete-stack \
--stack-name $1 \
--region=us-east-1
######################################################################
echo "WAIT..."
aws cloudformation wait stack-delete-complete --stack-name $1
echo "$1 stack is deleted."
######################################################################