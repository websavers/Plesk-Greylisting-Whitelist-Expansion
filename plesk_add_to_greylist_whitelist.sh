#!/bin/bash

MY_SMTP="*.websavers.ca"

## Usage ##
# ./plesk_add_to_greylist_whitelist.sh

## Examples ##
# Email Address: /usr/local/psa/bin/grey_listing --update-server -whitelist add:*@domain.tld
# Server Domain: /usr/local/psa/bin/grey_listing --update-server -domains-whitelist add:MAILPPPPT02.example-mail.com #server name

WHITELIST_FILE=./combined_rspamd_domains
# Get whitelist file
if [ ! -f $WHITELIST_FILE ]; then
  curl -O https://whitelist.maven-group.org/lists/combined_rspamd_domains
fi

# Append our own custom white list entries to file
echo "mail.asana.com" >> $WHITELIST_FILE
echo $MY_SMTP >> $WHITELIST_FILE

# Save non-comment lines of file to var
WHITELIST=$(sed '/^ *#/d;s/#.*//' $WHITELIST_FILE)

IFS=$'\n' # make newlines the only separator (ignore spaces)
for line in $WHITELIST; do
  echo -Adding $line to Plesk greylisting whitelist
  plesk bin grey_listing --update-server -domains-whitelist add:*${line}
done

