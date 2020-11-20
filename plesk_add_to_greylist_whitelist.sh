#!/bin/bash

## Usage ##
# ./plesk_add_to_greylist_whitelist.sh

CUSTOM_WHITELIST_FILE=./custom_domains
PUBLIC_WHITELIST_FILE=./combined_rspamd_domains

# Get public whitelist file
if [ ! -f $PUBLIC_WHITELIST_FILE ]; then
  curl -O https://whitelist.maven-group.org/lists/combined_rspamd_domains
fi
# Get local/custom whitelist file
if [ ! -f $CUSTOM_WHITELIST_FILE ]; then
  curl -O https://raw.githubusercontent.com/websavers/Plesk-Greylisting-Whitelist-Expansion/master/custom_domains
fi

# Save non-comment lines of file to var
CUSTOM_WHITELIST=$(sed '/^ *#/d;s/#.*//' $CUSTOM_WHITELIST_FILE)
PUBLIC_WHITELIST=$(sed '/^ *#/d;s/#.*//' $PUBLIC_WHITELIST_FILE)

EXISTING_CONFIG=$(plesk bin grey_listing --info-server)

function add_to_plesk_whitelist {
  local DOMAIN=$1
  if [[ $EXISTING_CONFIG = *$DOMAIN* ]]; then
    echo -Skipping ${DOMAIN}: already in whitelist
  else
    echo -Adding ${DOMAIN} to Plesk greylisting whitelist
    plesk bin grey_listing --update-server -domains-whitelist add:*.${DOMAIN}
  fi
}

IFS=$'\n' # make newlines the only separator (ignore spaces)
for domain in $PUBLIC_WHITELIST; do
  add_to_plesk_whitelist $domain
done
for domain in $CUSTOM_WHITELIST; do
  add_to_plesk_whitelist $domain
done

rm -rf custom_domains combined_rspamd_domains