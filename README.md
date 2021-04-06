# OpenVPN AS simple setup

Quick and Dirty way to setup up a base OPENVPN Access server running in AWS. This is a limited 2 users license from OpenVpn.  

## Prerequisite
1. You will need a base AWSCLI installed in your local Mac to run the AWS CloudFormation template.
```bash
pip install -U pip setuptools
pip install awscli
```
2. You should already have the Private SSH KEY that is generated which is paired with the SSH PUBLIC Key. 

## Access the Existing OPENVPN AS:
 
To access the existing OPENVPN AS GUI that was previously provisioned, you can retrieve the password from the server as the following:

```bash
ssh -I ~/.ssh/<PRIVATEKEY> openvpnas@54.208.124.206 'cat opvnpasswd'
```

Once you have the key, you may enter the OpenVpn AS website as such,
[OPENVPNAS ](https://54.208.124.206/admin/)

```Note: this is a temporary server, the above IP will only exist for the duration of this exercise. The AWS resources in this page will self destruct after few days. Nothing will be kept! ```


## Install the OPENVPN AS from scratch

Before you can run the automated script to create your own OpenVPN AS, you will need the AWS Access/Secret to run the AWS CloudFormation.

To retrieve the API key, 
```bash
ssh -i ~/.ssh/<PRIVATEKEY> openvpnas@54.208.124.206 'cat awsSecret.txt'
```

Once you have the Access/Secret pair, you may use it to run the following script with your own RSA private key provided by you
### Usage

```bash
bash auto-openvps-as.sh <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY> <SSHKEYPAIR>
```

After few minutes, the script will return back to you with an admin URL and temporary password to login to the GUI


Once you are successfully login, you can download and install a client tool to login to the VPN tunnel,

https://openvpn.net/vpn-server-resources/installation-guide-for-openvpn-connect-client-on-macos/ 


## Reference notes:
https://openvpn.net/vpn-server-resources/how-to-use-the-access-server-aws-launcher/