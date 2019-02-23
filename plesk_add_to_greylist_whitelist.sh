#!/bin/bash

MY_DOMAIN="websavers.ca"
#MailChimp: mail249.sea81.mcsv.net
#Asana: mail.asana.com
#Kijiji: rts.kijiji.ca
#BestBuy: mta.communications.bestbuypromotions.ca
#Eastlink: mta03.eastlink.ca
CUSTOM_DOMAINS=(mcsv.net asana.com kijiji.ca communications.bestbuypromotions.ca eastlink.ca)

## Usage ##
# ./plesk_add_to_greylist_whitelist.sh

## Examples ##
# Email Address: plesk bin grey_listing --update-server -whitelist add:*@domain.tld
# Server Domain: plesk bin grey_listing --update-server -domains-whitelist add:MAILPPPPT02.example-mail.com #server name
# List Whitelist: plesk bin grey_listing --info-server

WHITELIST_FILE=./combined_rspamd_domains
# Get whitelist file
if [ ! -f $WHITELIST_FILE ]; then
  curl -O https://whitelist.maven-group.org/lists/combined_rspamd_domains
fi

# Append our own custom white list entries to file
for domain in ${CUSTOM_DOMAINS[@]}; do
  echo ${domain} >> $WHITELIST_FILE 
done
echo $MY_DOMAIN >> $WHITELIST_FILE

# Save non-comment lines of file to var
WHITELIST=$(sed '/^ *#/d;s/#.*//' $WHITELIST_FILE)

IFS=$'\n' # make newlines the only separator (ignore spaces)
for line in $WHITELIST; do
  echo -Adding $line to Plesk greylisting whitelist
  plesk bin grey_listing --update-server -domains-whitelist add:*.${line}
done

