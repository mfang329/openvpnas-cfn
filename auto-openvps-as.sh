#!/bin/bash

# Access and Secret key is stored in the OpenVpn's home awsSecret.txt
if [ $# -ne 3 ]; then
    echo "$0: usage: $0 AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY SSHKEYPAIR"
    exit 1
fi

access=$1
secrite=$2 

# assign access/secret value for this script
export AWS_ACCESS_KEY_ID=$access
export AWS_SECRET_ACCESS_KEY=$secrite
export AWS_DEFAULT_REGION=us-east-1

SSHKEYPAIR=$3

aws cloudformation deploy \
    --template-file OpenVPN_AccessServer_AWS-launcher.json \
    --stack-name  OpenVPNAccessServer \
    --parameter-overrides \
      ActivationKey=ewogICJub25jZSIgOiAiNTY2ODA4QTUwQUUxN0MwOTA1NkRGOUNCMDhEODI0NDFCQTdFNEIyMUFBQzM4MUJBOTgxOEE5OEI3ODFFODJFQSIsCiAgInN1YmtleSIgOiAiQVNVdmZRellVdnZPdURQc0Z5UXJWdFNfQVNpcGpBcUtLQVBRTWRwTm5jQ21MUGZZRWtjZ1NMektfZGE0YjUwOWU3NTZlZjRhZWFkNDI2YzY0NTUwNGY3Mzg2NjM3NzljMiIsCiAgImlhdCIgOiAxNjE3NTk5OTk2Cn0= \
      InstanceName=OpenVPNAccessServer \
      InstanceType=t3.micro \
      KeyName=$SSHKEYPAIR \
      SubnetId=subnet-1e9bf678 \
      VpcId=vpc-358e3748 \
    --capabilities  CAPABILITY_IAM


OPENVPNACCESSINFO=`aws cloudformation describe-stacks \
  --stack-name OpenVPNAccessServer \
  --output json \
  --query "Stacks[0].Outputs[*].OutputValue"` 

echo -e "\n\nOpenVpn Access URL and Temporary password are : \n  $OPENVPNACCESSINFO"